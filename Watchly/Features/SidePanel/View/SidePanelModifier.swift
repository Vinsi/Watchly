//
//  SidePanelModifier.swift
//  Watchly
//
//  Created by Vinsi on 05/06/2025.
//

import SwiftUI

struct SidePanelModifier<SidePanel: View>: ViewModifier {
    @ViewBuilder var sidePanel: () -> SidePanel
    @Binding var isPresented: Bool

    @GestureState private var dragOffset: CGFloat = 0
    private let panelWidth: CGFloat = Layout.deviceScreen.width(0.75)

    func body(content: Content) -> some View {
        ZStack(alignment: .trailing) {
            content
                .disabled(isPresented)

            if isPresented {
                Color.purple.opacity(0.1).shadow(color: .purple, radius: 2).blur(radius: 3)
                    .ignoresSafeArea()
                    .onTapGesture {
                        withAnimation {
                            isPresented = false
                        }
                    }
            }

            sidePanel()
                .frame(width: panelWidth)
                .background(Color(.systemBackground))
                .overlay(
                    Rectangle()
                        .frame(width: 1)
                        .foregroundColor(Color.purple.opacity(0.8))
                        .ignoresSafeArea(),

                    alignment: .leading
                )
                .offset(x: isPresented ? 0 : panelWidth + dragOffset)
                .gesture(
                    DragGesture()
                        .updating($dragOffset) { value, state, _ in
                            if value.translation.width < 0 {
                                state = value.translation.width
                            }
                        }
                        .onEnded { value in
                            if value.translation.width < -100 {
                                withAnimation {
                                    isPresented = false
                                }
                            }
                        }
                )
                .animation(.easeInOut, value: isPresented)
        }
    }
}
