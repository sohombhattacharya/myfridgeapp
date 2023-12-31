import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            MainView()
                .navigationTitle("Fridge Inventory")
                .toolbar {
                    ToolbarItem() {
                        NavigationLink(destination: AddView()) {
                            Image(systemName: "plus")
                        }
                    }
                }
        }
    }
}
