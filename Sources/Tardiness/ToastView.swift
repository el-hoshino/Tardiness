//
//  File.swift
//  
//
//  Created by 史 翔新 on 2024/04/17.
//

import SwiftUI

struct ToastView: View {
    var toastHandler: ToastHandler

    private var toastHidingDuration: Duration {
        .milliseconds(10)
    }

    public var body: some View {
        Group {
            if let toastMessage = toastHandler.currentToastMessage {
                Text(toastMessage)
                    .font(.caption)
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 16)
                    .background(Color.brown)
                    .padding(.horizontal, 16)
                    .padding(.top, 32)
                    .transition(MoveTransition.move(edge: .top).combined(with: .opacity))
            }
        }
        .animation(.easeInOut, value: toastHandler.currentToastMessage)
        .onTapGesture {
            toastHandler.skipCurrent(in: toastHidingDuration)
        }
    }
}
