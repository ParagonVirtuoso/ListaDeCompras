import Foundation
import SwiftData

@Model
final class ShoppingItem {
    var id: UUID
    var name: String
    var quantity: Int
    var isCompleted: Bool
    var category: Category?
    var createdAt: Date
    
    init(id: UUID = UUID(), name: String, quantity: Int = 1, isCompleted: Bool = false, category: Category? = nil, createdAt: Date = Date()) {
        self.id = id
        self.name = name
        self.quantity = quantity
        self.isCompleted = isCompleted
        self.category = category
        self.createdAt = createdAt
    }
} 