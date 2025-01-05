import SwiftUI

struct ToastView: View {
    let message: String
    let type: ToastType
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: type.iconName)
                .foregroundColor(type.iconColor)
            
            Text(message)
                .font(.subheadline)
                .foregroundColor(Constants.Colors.text)
            
            Spacer()
        }
        .padding()
        .background(Constants.Colors.secondaryBackground)
        .cornerRadius(Constants.Layout.cornerRadius)
        .shadow(radius: 4)
        .padding(.horizontal)
    }
}

enum ToastType {
    case success
    case error
    case info
    
    var iconName: String {
        switch self {
        case .success: return "checkmark.circle.fill"
        case .error: return "exclamationmark.circle.fill"
        case .info: return "info.circle.fill"
        }
    }
    
    var iconColor: Color {
        switch self {
        case .success: return .green
        case .error: return .red
        case .info: return .blue
        }
    }
}

#Preview {
    VStack(spacing: 20) {
        ToastView(message: "Operação realizada com sucesso!", type: .success)
        ToastView(message: "Ocorreu um erro!", type: .error)
        ToastView(message: "Informação importante", type: .info)
    }
} 