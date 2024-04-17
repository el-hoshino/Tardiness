//
//  ContentView.swift
//  XcodeProject
//
//  Created by 史 翔新 on 2024/04/17.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
            ChildView()
        }
    }
}

#Preview {
    ContentView()
}
