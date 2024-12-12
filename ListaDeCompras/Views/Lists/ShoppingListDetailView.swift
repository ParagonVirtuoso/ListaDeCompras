import SwiftUI
import SwiftData

struct ShoppingListDetailView: View {
    let list: ShoppingList
    @StateObject private var viewModel: ItemViewModel
    @State private var newItemName = ""
    
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
                        
                        Text("Qtd: \(item.quantity)")
                            .foregroundColor(.secondary)
                    }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        viewModel.removeItem(viewModel.items[index])
                    }
                }
            }
            
            Section {
                HStack {
                    TextField("Novo item", text: $newItemName)
                    Button("Adicionar") {
                        viewModel.addItem(name: newItemName)
                        newItemName = ""
                    }
                    .disabled(newItemName.isEmpty)
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