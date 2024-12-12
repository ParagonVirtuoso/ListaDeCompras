import SwiftUI

struct ThemeSwitcher: View {
    @Binding var isDarkMode: Bool
    
    var body: some View {
        Button(action: {
            withAnimation {
                isDarkMode.toggle()
            }
        }) {
            Image(systemName: isDarkMode ? "sun.max.fill" : "moon.fill")
                .font(.system(size: 20))
                .foregroundColor(isDarkMode ? .yellow : .primary)
                .padding(8)
                .background(Constants.Colors.secondaryBackground)
                .clipShape(Circle())
        }
    }
}

#Preview {
    ThemeSwitcher(isDarkMode: .constant(false))
} 