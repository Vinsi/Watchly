//
//  ShimmerModifier.swift
//  Watchly
//
//  Created by Vinsi on 02/06/2025.
//
import SwiftUI

@ViewBuilder
func placeholderImage(theme: Theme) -> some View {
    Rectangle()
        .foregroundColor(Color.gray)
        .opacity(0.3)
        .shimmer()
}

extension View {
    func shimmer() -> some View {
        modifier(ShimmerModifier())
    }
}

struct ShimmerModifier: ViewModifier {
    @State private var offset: CGFloat = -200
    @State private var viewSize: CGSize = .zero

    func body(content: Content) -> some View {
        content
            .background(
                GeometryReader { geo in
                    Color.clear
                        .onAppear {
                            viewSize = geo.size
                        }
                }
            )
            .overlay(
                shimmerOverlay
                    .frame(width: viewSize.width * 1.5) // Wider shimmer to animate across
                    .offset(x: offset)
                    .mask(content)
            )
            .onAppear {
                offset = -viewSize.width * 1.5 // Start far left
                withAnimation(.linear(duration: 1.5).repeatForever(autoreverses: false)) {
                    offset = viewSize.width * 1.5 // Move far right
                }
            }
    }

    private var shimmerOverlay: some View {
        LinearGradient(
            gradient: Gradient(colors: [
                Color.white.opacity(0.0),
                Color.black.opacity(0.1),
                Color.white.opacity(0.0),
            ]),
            startPoint: .top,
            endPoint: .bottom
        )
        .rotationEffect(.degrees(20))
        .blendMode(.plusLighter)
    }
}
