import SwiftUI

extension View {
    func standardPadding() -> some View {
        self.padding(Constants.Layout.padding)
    }
    
    func standardCornerRadius() -> some View {
        self.cornerRadius(Constants.Layout.cornerRadius)
    }
} 