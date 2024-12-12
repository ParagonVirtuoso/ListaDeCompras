import SwiftUI
import SwiftData

@MainActor
class ItemViewModel: ObservableObject {
    @Published var items: [ShoppingItem] = []
    @Published var errorMessage: String?
    @Published var newItemQuantity: Int = 1
    
    private let modelContext: ModelContext
    private let list: ShoppingList
    
    init(modelContext: ModelContext, list: ShoppingList) {
        self.modelContext = modelContext
        self.list = list
        self.items = list.items
    }
    
    func addItem(name: String, quantity: Int = 1) {
        let newItem = ShoppingItem(name: name, quantity: quantity)
        list.items.append(newItem)
        
        do {
            try modelContext.save()
            items = list.items
            newItemQuantity = 1
        } catch {
            errorMessage = "Erro ao adicionar item: \(error.localizedDescription)"
        }
    }
    
    func updateItemQuantity(_ item: ShoppingItem, quantity: Int) {
        item.quantity = quantity
        
        do {
            try modelContext.save()
            items = list.items
        } catch {
            errorMessage = "Erro ao atualizar quantidade: \(error.localizedDescription)"
        }
    }
    
    func removeItem(_ item: ShoppingItem) {
        if let index = list.items.firstIndex(where: { $0.id == item.id }) {
            list.items.remove(at: index)
            
            do {
                try modelContext.save()
                items = list.items
            } catch {
                errorMessage = "Erro ao remover item: \(error.localizedDescription)"
            }
        }
    }
    
    func toggleItemCompletion(_ item: ShoppingItem) {
        item.isCompleted.toggle()
        
        do {
            try modelContext.save()
            items = list.items
        } catch {
            errorMessage = "Erro ao atualizar item: \(error.localizedDescription)"
        }
    }
} 