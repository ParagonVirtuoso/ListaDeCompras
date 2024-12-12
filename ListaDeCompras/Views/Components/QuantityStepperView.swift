import SwiftUI

struct QuantityStepperView: View {
    @Binding var quantity: Int
    let minValue: Int
    let maxValue: Int
    
    init(quantity: Binding<Int>, minValue: Int = 1, maxValue: Int = 99) {
        self._quantity = quantity
        self.minValue = minValue
        self.maxValue = maxValue
    }
    
    var body: some View {
        HStack {
            Button(action: decrementQuantity) {
                Image(systemName: "minus.circle.fill")
                    .foregroundColor(quantity > minValue ? Constants.Colors.primary : Constants.Colors.secondary)
            }
            .disabled(quantity <= minValue)
            
            Text("\(quantity)")
                .frame(minWidth: 30)
                .foregroundColor(Constants.Colors.text)
            
            Button(action: incrementQuantity) {
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(quantity < maxValue ? Constants.Colors.primary : Constants.Colors.secondary)
            }
            .disabled(quantity >= maxValue)
        }
    }
    
    private func incrementQuantity() {
        if quantity < maxValue {
            quantity += 1
        }
    }
    
    private func decrementQuantity() {
        if quantity > minValue {
            quantity -= 1
        }
    }
} 