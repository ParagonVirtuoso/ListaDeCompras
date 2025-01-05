import SwiftUI
import SwiftData

struct ShoppingListDetailView: View {
    let list: ShoppingList
    @StateObject private var viewModel: ItemViewModel
    @State private var newItemName = ""
    @State private var itemToDelete: ShoppingItem? = nil
    @State private var showingDeleteAlert = false
    @EnvironmentObject private var toastVM: ToastViewModel
    
    init(list: ShoppingList, modelContext: ModelContext) {
        self.list = list
        _viewModel = StateObject(wrappedValue: ItemViewModel(modelContext: modelContext, list: list, toastVM: ToastViewModel()))
    }
    
    var body: some View {
        List {
            Section {
                ForEach(viewModel.items) { item in
                    HStack {
                        Button(action: { viewModel.toggleItemCompletion(item) }) {
                            Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
                        }
                        .buttonStyle(.plain)
                        
                        Text(item.name)
                            .strikethrough(item.isCompleted)
                        
                        Spacer()
                        
                        QuantityStepperView(
                            quantity: Binding(
                                get: { item.quantity },
                                set: { viewModel.updateItemQuantity(item, quantity: $0) }
                            )
                        )
                        .frame(minWidth: 100)
                    }
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            itemToDelete = item
                            showingDeleteAlert = true
                        } label: {
                            Label("Deletar", systemImage: "trash")
                        }
                    }
                }
            }
            
            Section {
                VStack(spacing: 10) {
                    TextField("Novo item", text: $newItemName)
                    
                    if !newItemName.isEmpty {
                        HStack {
                            Text("Quantidade:")
                            QuantityStepperView(quantity: $viewModel.newItemQuantity)
                                .frame(minWidth: 100)
                        }
                    }
                    
                    Button("Adicionar") {
                        let itemName = newItemName
                        viewModel.addItem(name: newItemName, quantity: viewModel.newItemQuantity)
                        newItemName = ""
                        toastVM.showSuccess("Item '\(itemName)' adicionado com sucesso!")
                    }
                    .disabled(newItemName.isEmpty)
                    .frame(maxWidth: .infinity)
                    .buttonStyle(.borderedProminent)
                }
            }
        }
        .navigationTitle(list.name)
        .alert("Confirmar exclusão", isPresented: $showingDeleteAlert) {
            Button("Cancelar", role: .cancel) {}
            Button("Deletar", role: .destructive) {
                if let item = itemToDelete {
                    let itemName = item.name
                    viewModel.removeItem(item)
                    toastVM.showSuccess("Item '\(itemName)' removido com sucesso!")
                }
            }
        } message: {
            if let item = itemToDelete {
                Text("Tem certeza que deseja excluir o item '\(item.name)'? Esta ação não pode ser desfeita.")
            }
        }
    }
} 