//
//  DisplayToastAction+Environment.swift
//
//
//  Created by 史 翔新 on 2024/04/17.
//

import SwiftUI
import OSLog

public struct DisplayToastAction: Sendable {
    private let handler: ToastHandler?
    private let logger = Logger()
    init(handler: ToastHandler?) {
        self.handler = handler
    }

    @MainActor
    public func callAsFunction(_ toast: String) {
        if let handler {
            handler.queueMessage(toast)
        } else {
            let errorMessage = """
                Calling DisplayToastAction with no ToastHandler. This means you forgot to set the environment.
                Toast message: \(toast).
                """
            assertionFailure(errorMessage)
            logger.warning("\(errorMessage)")
        }
    }
}

extension DisplayToastAction {
    static func dummy() -> Self {
        return .init(handler: nil)
    }
}

public extension EnvironmentValues {
    var displayToast: DisplayToastAction {
        .init(handler: toastHandler)
    }
}
