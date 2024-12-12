import SwiftUI

enum Constants {
    enum Colors {
        static let primary = Color.accentColor
        static let secondary = Color.secondary
        
        static let background = Color(.systemBackground)
        static let secondaryBackground = Color(.secondarySystemBackground)
        
        static let text = Color(.label)
        static let secondaryText = Color(.secondaryLabel)
        
        static let groupedBackground = Color(.systemGroupedBackground)
        static let listBackground = Color(.systemGroupedBackground)
    }
    
    enum Layout {
        static let padding: CGFloat = 16
        static let cornerRadius: CGFloat = 8
    }
    
    enum Text {
        static let appName = "Lista de Compras"
        static let newList = "Nova Lista"
        static let cancel = "Cancelar"
        static let save = "Salvar"
        static let delete = "Deletar"
    }
    
    enum Theme {
        static let preferredColorScheme: ColorScheme? = nil
    }
} 