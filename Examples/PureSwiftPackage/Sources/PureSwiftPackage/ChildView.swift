//
//  File.swift
//  
//
//  Created by 史 翔新 on 2024/04/17.
//

import SwiftUI
import Tardiness

struct ChildView: View {
    
    @Environment(\.displayToast) var displayToast
    
    var body: some View {
        
        List(0 ..< 20, id: \.self) {
            Text("\($0)")
        }
        .refreshable {
            try? await Task.sleep(for: .seconds(2))
            displayToast("Refreshed!")
        }
        
    }
    
}
