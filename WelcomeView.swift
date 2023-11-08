
import SwiftUI
import SwiftData

struct WelcomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Welcome, Admin!")
                    .font(.title)
                    .foregroundColor(.cyan)
                    .padding(.top, 5)
                    .multilineTextAlignment(.leading)
   
                
                NavigationLink(destination: StockManagementView()) {
                    Text("Manage Stock")
                        .frame(width: 200, height: 55)
                        .background(Color.blue)
                        .cornerRadius(30)
                        .foregroundColor(.white)
                }
                .buttonStyle(.plain)
                .navigationTitle("Home")
                
                NavigationLink(destination: CustomerManagementView()) {
                    Text("Manage Customers")
                        .frame(width: 200, height: 55)
                        .background(Color.green)
                        .cornerRadius(30)
                        .foregroundColor(.white)
                }
                .buttonStyle(.plain)
                .navigationTitle("Home")
                
                NavigationLink(destination: WarehouseManagementView()) {
                    Text("Manage Warehouse")
                        .frame(width: 200, height: 55)
                        .background(Color.yellow)
                        .cornerRadius(30)
                        .foregroundColor(.white)
                }
                .buttonStyle(.plain)
                .navigationTitle("Home")
                
                NavigationLink(destination: InvoiceManagementView()) {
                    Text("Invoices")
                        .frame(width: 200, height: 55)
                        .background(Color.purple)
                        .cornerRadius(30)
                        .foregroundColor(.white)
                }
                .buttonStyle(.plain)
            }
            .navigationTitle("Home")
           
           
        }
    }
}

#Preview {
    WelcomeView()
        .modelContainer(for: Item.self, inMemory: true)
}
