import SwiftUI

@MainActor
class ToastViewModel: ObservableObject {
    @Published var currentToast: Toast?
    @Published var isShowing = false
    
    struct Toast: Equatable {
        let message: String
        let type: ToastType
        let duration: Double
    }
    
    func show(message: String, type: ToastType = .info, duration: Double = 2.0) {
        currentToast = Toast(message: message, type: type, duration: duration)
        isShowing = true
        
        Task {
            try? await Task.sleep(for: .seconds(duration))
            isShowing = false
            currentToast = nil
        }
    }
    
    func showSuccess(_ message: String) {
        show(message: message, type: .success)
    }
    
    func showError(_ message: String) {
        show(message: message, type: .error)
    }
    
    func showInfo(_ message: String) {
        show(message: message, type: .info)
    }
} 