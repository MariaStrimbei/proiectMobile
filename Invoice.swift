import SwiftUI
import SwiftData

@Model
final class Invoice {
    var invoiceNumber: String
    var customerName: String
    var amount: Double
    var createdOn: Date
    var paymentDueDate: Date
    
    init(invoiceNumber: String, customerName: String, amount: Double, createdOn: Date, paymentDueDate:Date) {
        self.invoiceNumber = invoiceNumber
        self.customerName = customerName
        self.amount = amount
        self.createdOn = createdOn
        self.paymentDueDate = createdOn 
    }
}
