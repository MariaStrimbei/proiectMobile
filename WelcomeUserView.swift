import SwiftUI

struct WelcomeUserView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var showCatalog = false 

    var body: some View {
        VStack {
            Text("Welcome, User!")
                .font(.title)
                .padding()

            NavigationLink(destination: CatalogView(), isActive: $showCatalog) {
                EmptyView()
            }

            Button(action: {
                showCatalog = true 
            }) {
                Text("Go to Catalog")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
        }
    }
}
