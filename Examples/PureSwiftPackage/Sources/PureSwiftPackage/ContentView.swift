// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI
import Tardiness

struct ContentView: View {
    
    @State private var toastHandler: ToastHandler = .init()
    
    var body: some View {
        
        VStack {
            
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            
            Text("Hello, world!")
            
            ChildView()
            
        }
        .displayToast(handledBy: toastHandler)
        
    }
    
}

#Preview {
    ContentView()
}
