import SwiftUI
import SwiftData

@MainActor
class ItemViewModel: ObservableObject {
    @Published var items: [ShoppingItem] = []
    @Published var newItemQuantity: Int = 1
    
    private let modelContext: ModelContext
    private let list: ShoppingList
    @ObservedObject var toastVM: ToastViewModel
    
    init(modelContext: ModelContext, list: ShoppingList, toastVM: ToastViewModel) {
        self.modelContext = modelContext
        self.list = list
        self.toastVM = toastVM
        self.items = list.items
    }
    
    func addItem(name: String, quantity: Int = 1) {
        let newItem = ShoppingItem(name: name, quantity: quantity)
        list.items.append(newItem)
        
        do {
            try modelContext.save()
            items = list.items
            newItemQuantity = 1
            toastVM.showSuccess("Item adicionado com sucesso!")
        } catch {
            toastVM.showError("Erro ao adicionar item: \(error.localizedDescription)")
        }
    }
    
    func updateItemQuantity(_ item: ShoppingItem, quantity: Int) {
        guard quantity > 0 else { return }
        
        item.quantity = quantity
        
        do {
            try modelContext.save()
            objectWillChange.send()
            items = list.items
            
            if quantity % 5 == 0 {
                toastVM.showSuccess("Quantidade atualizada para \(quantity)!")
            }
        } catch {
            toastVM.showError("Erro ao atualizar quantidade: \(error.localizedDescription)")
        }
    }
    
    func removeItem(_ item: ShoppingItem) {
        if let index = list.items.firstIndex(where: { $0.id == item.id }) {
            list.items.remove(at: index)
            
            do {
                try modelContext.save()
                items = list.items
                toastVM.showSuccess("Item removido com sucesso!")
            } catch {
                toastVM.showError("Erro ao remover item: \(error.localizedDescription)")
            }
        }
    }
    
    func toggleItemCompletion(_ item: ShoppingItem) {
        item.isCompleted.toggle()
        
        do {
            try modelContext.save()
            items = list.items
            toastVM.showSuccess(item.isCompleted ? "Item marcado como concluído!" : "Item desmarcado!")
        } catch {
            toastVM.showError("Erro ao atualizar item: \(error.localizedDescription)")
        }
    }
} 