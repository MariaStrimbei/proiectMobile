import SwiftUI
import SwiftData

struct CustomerEditView: View {
    @Environment(\.modelContext) private var modelContext
    @State var customer: Customer
    @State private var editedName: String
    @State private var editedPhone: String
    @State private var editedBusinessName: String
    @State private var editedEmail: String
    @State private var editedAddress: String
    @State private var isSaved: Bool = false
    @State private var isDeleted: Bool = false

    init(customer: Customer) {
        self.customer = customer
        self._editedName = State(initialValue: customer.name)
        self._editedPhone = State(initialValue: customer.phoneNumber)
        self._editedBusinessName = State(initialValue: customer.businessName)
        self._editedEmail = State(initialValue: customer.email)
        self._editedAddress = State(initialValue: customer.address)
    }

    var body: some View {
        Form {
            TextField("Name", text: $editedName)
            TextField("Phone", text: $editedPhone)
            TextField("Business Name", text: $editedBusinessName)
            TextField("Email", text: $editedEmail)
            TextField("Address", text: $editedAddress)
            Button("Save") {
              
                customer.name = editedName
                customer.phoneNumber = editedPhone
                customer.businessName = editedBusinessName
                customer.email = editedEmail
                customer.address = editedAddress
                try? modelContext.save()
                isSaved = true
            }
            .alert(isPresented: $isSaved) {
                Alert(
                    title: Text("Customer Saved"),
                    message: Text("Customer saved successfully"),
                    dismissButton: .default(Text("OK"), action: {
                        isSaved = false
                    })
                )
            }
            Button("Delete Customer", role: .destructive) {
           
                isDeleted = true
            }
        }
        .navigationTitle("Edit Customer")
        .navigationBarTitleDisplayMode(.inline)

        .alert(isPresented: $isDeleted) {
            Alert(
                title: Text("Confirm Deletion"),
                message: Text("Are you sure you want to delete this customer?"),
                primaryButton: .destructive(Text("Delete"), action: {
                    modelContext.delete(customer)
                    try? modelContext.save()
                }),
                secondaryButton: .cancel({
                    isDeleted = false
                })
            )
        }
    }
}

struct CustomerManagementView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var customers: [Customer]
    @State private var newCustomerName: String = ""

    var body: some View {
        NavigationView {
            List {
                ForEach(customers) { customer in
                    NavigationLink(destination: CustomerEditView(customer: customer)) {
                        Text(customer.name)
                    }
                }
                .onDelete(perform: deleteCustomers)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        TextField("New Customer Name", text: $newCustomerName)
                            .textFieldStyle(.roundedBorder)
                        Button(action: addCustomer) {
                            Image(systemName: "plus.circle.fill")
                                .foregroundColor(.green)
                        }
                    }
                }
            }
        }
        .navigationTitle("Customer Management")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func addCustomer() {
        withAnimation {
            let newCustomer = Customer(name: newCustomerName, phoneNumber: "", addedAt: Date(), businessName: "", email: "", address: "")
            modelContext.insert(newCustomer)
            newCustomerName = "" 
        }
    }

    private func deleteCustomers(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(customers[index])
            }
        }
    }
}
#Preview {
    CustomerManagementView()
        .modelContainer(for: Customer.self, inMemory: true)
}
