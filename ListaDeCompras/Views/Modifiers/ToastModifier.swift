import SwiftUI

struct ToastModifier: ViewModifier {
    @ObservedObject var toastVM: ToastViewModel
    
    func body(content: Content) -> some View {
        content
            .overlay(alignment: .bottom) {
                if let toast = toastVM.currentToast, toastVM.isShowing {
                    ToastView(message: toast.message, type: toast.type)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                        .animation(.spring(), value: toastVM.isShowing)
                        .padding(.bottom, 20)
                }
            }
    }
}

extension View {
    func toast(using toastVM: ToastViewModel) -> some View {
        modifier(ToastModifier(toastVM: toastVM))
    }
} 