//
//  XcodeProjectApp.swift
//  XcodeProject
//
//  Created by 史 翔新 on 2024/04/17.
//

import SwiftUI
import Tardiness // ← This package should be added in Package Dependencies tab from Xcode project settings, but since it's direct ancestor package, I have to add it directly in Project file trees.

@main
struct XcodeProjectApp: App {
    
    @State private var toastHandler: ToastHandler = .init()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .displayToast(handledBy: toastHandler)
        }
    }
}
