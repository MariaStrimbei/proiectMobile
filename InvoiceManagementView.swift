import SwiftUI
import SwiftData
struct InvoiceEditView: View {
    @Environment(\.modelContext) private var modelContext
    @State var invoice: Invoice
    @State private var editedCustomerName: String
    @State private var editedAmount: String
    @State private var isSaved: Bool = false
    @State private var isDeleted: Bool = false

    init(invoice: Invoice) {
        self.invoice = invoice
        self._editedCustomerName = State(initialValue: invoice.customerName)
        self._editedAmount = State(initialValue: String(invoice.amount))
    }

    var body: some View {
        Form {
            TextField("Customer Name", text: $editedCustomerName)
            TextField("Amount", text: $editedAmount)
                .keyboardType(.decimalPad)
            
            // Display the paymentDueDate
            Text("Payment Due Date: \(formattedDate(invoice.paymentDueDate))")
            
            Button("Save") {
                invoice.customerName = editedCustomerName
                if let amount = Double(editedAmount) {
                    invoice.amount = amount
                }
                try? modelContext.save()
                isSaved = true
            }
            .alert(isPresented: $isSaved) {
                Alert(
                    title: Text("Invoice Saved"),
                    message: Text("Invoice saved successfully"),
                    dismissButton: .default(Text("OK"), action: {
                        isSaved = false
                    })
                )
            }
            Button("Delete Invoice", role: .destructive) {
                isDeleted = true
            }
        }
        .navigationTitle("Edit Invoice")
        .navigationBarTitleDisplayMode(.inline)

        .alert(isPresented: $isDeleted) {
            Alert(
                title: Text("Confirm Deletion"),
                message: Text("Are you sure you want to delete this invoice?"),
                primaryButton: .destructive(Text("Delete"), action: {
                    modelContext.delete(invoice)
                    try? modelContext.save()
                }),
                secondaryButton: .cancel({
                    isDeleted = false
                })
            )
        }
    }
    
    // Helper method to format a Date to a String
    private func formattedDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        return dateFormatter.string(from: date)
    }
}


struct InvoiceManagementView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var invoices: [Invoice]
    @State private var newCustomerName: String = ""
    @State private var newAmount: String = ""

    @State private var isAddingNewInvoice: Bool = false

    var body: some View {
        NavigationView {
            List {
                ForEach(invoices) { invoice in
                    NavigationLink(destination: InvoiceEditView(invoice: invoice)) {
                        Text("Invoice Number: \(invoice.invoiceNumber)")
                    }
                }
                .onDelete(perform: deleteInvoices)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    HStack {
                        if isAddingNewInvoice {
                            TextField("New Customer Name", text: $newCustomerName)
                                .textFieldStyle(.roundedBorder)
                            TextField("Amount", text: $newAmount)
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.decimalPad)
                            Button("Save") {
                                addInvoice()
                                isAddingNewInvoice = false
                            }
                        } else {
                            Button(action: {
                                isAddingNewInvoice = true
                            }) {
                                Text("New Invoice")
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Invoice Management")
        .navigationBarTitleDisplayMode(.inline)
    }

    private func addInvoice() {
        withAnimation {
            if let amount = Double(newAmount) {
                let invoiceNumber = "INV-\(UUID().uuidString.prefix(6))" // Generate a random invoice number
                let createdOn = Date()
                
                // Calculate payment due date (7 days from createdOn)
                let paymentDueDate: Date
                if let calculatedPaymentDueDate = Calendar.current.date(byAdding: .day, value: 7, to: createdOn) {
                    paymentDueDate = calculatedPaymentDueDate
                } else {
                    // Set a default value if the calculation fails
                    paymentDueDate = createdOn
                }
                
                let newInvoice = Invoice(invoiceNumber: invoiceNumber, customerName: newCustomerName, amount: amount, createdOn: createdOn, paymentDueDate: paymentDueDate)
                modelContext.insert(newInvoice)
                newCustomerName = ""
                newAmount = ""
            }
        }
    }

    private func deleteInvoices(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(invoices[index])
            }
        }
    }
}
#Preview {
    InvoiceManagementView()
        .modelContainer(for: Invoice.self, inMemory: true)
}
