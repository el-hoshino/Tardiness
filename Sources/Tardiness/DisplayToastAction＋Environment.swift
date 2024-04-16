//
//  DisplayToastAction+Environment.swift
//
//
//  Created by 史 翔新 on 2024/04/17.
//

import SwiftUI

typealias DisplayToastAction = @MainActor (String) -> Void

struct DisplayToastKey: EnvironmentKey {
    static var defaultValue: DisplayToastAction? = nil
}

extension EnvironmentValues {
    var displayToast: DisplayToastAction? {
        get { self[DisplayToastKey.self] }
        set { self[DisplayToastKey.self] = newValue }
    }
}
