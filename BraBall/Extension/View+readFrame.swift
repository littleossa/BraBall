//
//  View+readFrame.swift
//  BraBall
//

import SwiftUI

extension View {
    func readFrame(_ frame: Binding<CGRect>) -> some View {
        self.background(
                GeometryReader { proxy -> AnyView in
                    let rect = proxy.frame(in: .global)
                    if rect.integral != frame.wrappedValue.integral {
                        Task { @MainActor in
                            frame.wrappedValue = rect
                            print(rect)
                        }
                    }
                    return AnyView(EmptyView())
                }
        )
    }
}
