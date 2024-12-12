import SwiftUI
import SwiftData

struct ShoppingListDetailView: View {
    let list: ShoppingList
    @StateObject private var viewModel: ItemViewModel
    @State private var newItemName = ""
    @State private var editingItem: ShoppingItem?
    
    init(list: ShoppingList, modelContext: ModelContext) {
        self.list = list
        _viewModel = StateObject(wrappedValue: ItemViewModel(modelContext: modelContext, list: list))
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
                        
                        QuantityStepperView(quantity: Binding(
                            get: { item.quantity },
                            set: { viewModel.updateItemQuantity(item, quantity: $0) }
                        ))
                    }
                    .swipeActions(edge: .trailing) {
                        Button(role: .destructive) {
                            viewModel.removeItem(item)
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
                        }
                    }
                    
                    Button("Adicionar") {
                        viewModel.addItem(name: newItemName, quantity: viewModel.newItemQuantity)
                        newItemName = ""
                    }
                    .disabled(newItemName.isEmpty)
                    .frame(maxWidth: .infinity)
                    .buttonStyle(.borderedProminent)
                }
            }
        }
        .navigationTitle(list.name)
        .alert("Erro", isPresented: .constant(viewModel.errorMessage != nil)) {
            Button("OK") { viewModel.errorMessage = nil }
        } message: {
            Text(viewModel.errorMessage ?? "")
        }
    }
} 