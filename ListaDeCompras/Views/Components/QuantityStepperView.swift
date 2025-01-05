import SwiftUI

struct QuantityStepperView: View {
    @Binding var quantity: Int
    var onUpdate: ((Int) -> Void)? = nil
    
    var body: some View {
        HStack(spacing: 12) {
            Button(action: decrementQuantity) {
                Image(systemName: "minus.circle.fill")
                    .foregroundColor(quantity > 1 ? Constants.Colors.primary : Constants.Colors.secondary)
                    .font(.title3)
            }
            .buttonStyle(.plain)
            .disabled(quantity <= 1)
            
            Text("\(quantity)")
                .frame(minWidth: 30)
                .font(.headline)
                .contentTransition(.numericText())
            
            Button(action: incrementQuantity) {
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(Constants.Colors.primary)
                    .font(.title3)
            }
            .buttonStyle(.plain)
        }
        .onChange(of: quantity) { oldValue, newValue in
            onUpdate?(newValue)
        }
    }
    
    private func decrementQuantity() {
        if quantity > 1 {
            withAnimation(.spring(response: 0.3)) {
                quantity -= 1
            }
        }
    }
    
    private func incrementQuantity() {
        withAnimation(.spring(response: 0.3)) {
            quantity += 1
        }
    }
}

#Preview {
    QuantityStepperView(quantity: .constant(1))
} 
