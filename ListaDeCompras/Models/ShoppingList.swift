import Foundation
import SwiftData

@Model
final class ShoppingList {
    var id: UUID
    var name: String
    var items: [ShoppingItem]
    var createdAt: Date
    
    init(id: UUID = UUID(), name: String, items: [ShoppingItem] = [], createdAt: Date = Date()) {
        self.id = id
        self.name = name
        self.items = items
        self.createdAt = createdAt
    }
} 