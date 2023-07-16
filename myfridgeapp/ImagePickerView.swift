import SwiftUI
import UIKit
import Photos

struct ImagePickerView: UIViewControllerRepresentable {
    @Environment(\.presentationMode) var presentationMode
    @Binding var isPresented: Bool
    @Binding var selectedImage: UIImage?

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePickerView

        init(_ parent: ImagePickerView) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let selectedImage = info[.originalImage] as? UIImage {
                parent.selectedImage = selectedImage
            }
            parent.isPresented = false
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.isPresented = false
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePickerView>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        imagePicker.sourceType = .photoLibrary
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePickerView>) {
        // No need to update the view controller
    }

    func checkPermission() {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        switch photoAuthorizationStatus {
        case .authorized:
            self.isPresented = true
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization { status in
                DispatchQueue.main.async {
                    if status == .authorized {
                        self.isPresented = true
                    }
                }
            }
        default:
            break
        }
    }
}
