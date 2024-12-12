import Foundation
import SwiftData

@Model
final class Category {
    var id: UUID
    var name: String
    var color: String
    
    init(id: UUID = UUID(), name: String, color: String) {
        self.id = id
        self.name = name
        self.color = color
    }
} 