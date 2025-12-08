//
//  File.swift
//  
//
//  Created by 史 翔新 on 2024/04/17.
//

import SwiftUI

public struct ToastDisplayModifier<Toast: View>: ViewModifier {
    var alignment: Alignment
    var toastHandler: ToastHandler
    var toastMaker: (ToastHandler) -> Toast

    public func body(content: Content) -> some View {
        content
            .overlay(alignment: alignment) {
                toastMaker(toastHandler)
            }
            .environment(\.toastHandler, toastHandler)
    }
}

public extension View {
    func displayToast<Toast: View>(
        on alignment: Alignment,
        handledBy toastHandler: ToastHandler,
        toastMaker: @escaping (ToastHandler) -> Toast,
    ) -> some View {
        self.modifier(
            ToastDisplayModifier(
                alignment: alignment,
                toastHandler: toastHandler,
                toastMaker: toastMaker
            )
        )
    }
}
