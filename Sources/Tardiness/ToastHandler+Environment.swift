//
//  ToastHandler.swift
//
//
//  Created by 史 翔新 on 2024/04/17.
//

import SwiftUI
import Observation

@Observable
public final class ToastHandler: Sendable {
    @MainActor
    public private(set) var currentToastMessage: LocalizedStringKey?

    @MainActor
    @ObservationIgnored private var toastQueue: [LocalizedStringKey] = []
    @MainActor
    @ObservationIgnored private var currentToastShowingTask: Task<Void, Never>?

    private var toastShowingDuration: Duration {
        .seconds(3)
    }

    private var defaultToastHidingDuration: Duration {
        .milliseconds(450)
    }
    
    public init() {}

    @MainActor
    public func queueMessage(_ message: LocalizedStringKey) {
        toastQueue.append(message)
        displayNextToastIfAvailable()
    }

    @_disfavoredOverload
    @available(*, deprecated, message: "Use `queueMessage(_:)` with `LocalizedStringKey` instead.")
    @MainActor
    public func queueMessage(_ message: String) {
        queueMessage(LocalizedStringKey(message))
    }

    @MainActor
    public func skipCurrent(in duration: Duration) {
        removeCurrentToast()
        Task {
            try? await Task.sleep(for: duration)
            displayNextToastIfAvailable()
        }
    }

    @MainActor
    private func displayNextToastIfAvailable() {
        guard currentToastMessage == nil, let message = toastQueue.first else { return }
        toastQueue.removeFirst()
        currentToastMessage = message

        currentToastShowingTask?.cancel()
        currentToastShowingTask = Task {
            do {
                try await Task.sleep(for: toastShowingDuration)
                if Task.isCancelled { return }
                skipCurrent(in: defaultToastHidingDuration)

            } catch {
                print("Task.sleep failed. Try Again")
            }
        }
    }

    @MainActor
    private func removeCurrentToast() {
        if currentToastMessage == nil { return }
        currentToastShowingTask?.cancel()
        currentToastMessage = nil
    }
}

import SwiftUI

extension EnvironmentValues {
    @Entry var toastHandler: ToastHandler?
}
