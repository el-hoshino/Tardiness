//
//  DisplayToastAction+Environment.swift
//
//
//  Created by 史 翔新 on 2024/04/17.
//

import SwiftUI
import OSLog

@MainActor
public struct DisplayToastAction {
    private let handler: ToastHandler?
    private let logger = Logger()
    init(handler: ToastHandler) {
        self.handler = handler
    }
    private init() {
        self.handler = nil
    }
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
    @MainActor
    static func dummy() -> Self {
        return .init()
    }
}

public struct DisplayToastKey: EnvironmentKey {
    @MainActor
    public static var defaultValue: DisplayToastAction = .dummy()
}

public extension EnvironmentValues {
    var displayToast: DisplayToastAction {
        get { self[DisplayToastKey.self] }
        set { self[DisplayToastKey.self] = newValue }
    }
}
