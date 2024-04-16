//
//  File.swift
//  
//
//  Created by 史 翔新 on 2024/04/17.
//

import SwiftUI

public struct ToastDisplayModifier<Toast: View>: ViewModifier {
    var toastHandler: ToastHandler
    var toast: Toast

    public func body(content: Content) -> some View {
        content
            .overlay(alignment: .top) {
                toast
            }
            .environment(\.displayToast, toastHandler.queueMessage(_:))
    }
}

public extension View {
    func displayToast<Toast: View>(handledBy toastHandler: ToastHandler, body: Toast) -> some View {
        self.modifier(ToastDisplayModifier(toastHandler: toastHandler, toast: body))
    }
    func displayToast(handledBy toastHandler: ToastHandler) -> some View {
        self.displayToast(handledBy: toastHandler, body: ToastView(toastHandler: toastHandler))
    }
}

#Preview {
    struct ToastDemo: View {
        @Environment(\.displayToast) var displayToast: DisplayToastAction?
        var body: some View {
            Text("Show Toast!")
                .onTapGesture {
                    displayToast?("sample")
                    displayToast?("sample2")
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .frame(maxHeight: .infinity, alignment: .center)
        }
    }
    let toastHandler: ToastHandler = ToastHandler()
    return ToastDemo()
        .displayToast(handledBy: toastHandler)
}
