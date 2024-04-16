//
//  DisplayToastAction+Environment.swift
//
//
//  Created by 史 翔新 on 2024/04/17.
//

import SwiftUI

public typealias DisplayToastAction = @MainActor (String) -> Void

public struct DisplayToastKey: EnvironmentKey {
    public static var defaultValue: DisplayToastAction? = nil
}

public extension EnvironmentValues {
    var displayToast: DisplayToastAction? {
        get { self[DisplayToastKey.self] }
        set { self[DisplayToastKey.self] = newValue }
    }
}
