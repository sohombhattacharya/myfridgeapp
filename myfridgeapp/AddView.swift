import SwiftUI
import UIKit
import Photos

struct AddView: View {
    @State private var selectedImage: UIImage? = nil
    @State private var showImagePicker: Bool = false
    @State private var userInput: String = ""

    var body: some View {
        NavigationView {
            VStack {
                if let image = selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 200, height: 200)
                } else {
                    Image(systemName: "photo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                }

                Button(action: {
                    let imagePickerView = ImagePickerView(isPresented: $showImagePicker, selectedImage: $selectedImage)
                    imagePickerView.checkPermission()
                }) {
                    Text("Upload Receipt!")
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .sheet(isPresented: $showImagePicker) {
                    ImagePickerView(isPresented: $showImagePicker, selectedImage: $selectedImage)
                }
        
                Text("Or just tell us what you bought! Here's an example input...")
                    .foregroundColor(Color.gray.opacity(0.5))
                    .padding(.horizontal, 4)
                    .padding(.vertical, 8)
                TextEditor(text: $userInput)
                    .frame(height: 150)
                    .padding()
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)

            }
            .padding()
        }
    }
}
