//
//  RatingBadgeView.swift
//  Watchly
//
//  Created by Vinsi on 05/06/2025.
//
import SwiftUI

struct RatingBadgeView: View {
    let rating: Double
    @EnvironmentObject var themeManager: ThemeManager

    var body: some View {
        let formattedRating = Int(rating.rounded())

        ZStack {
            Circle()
                .fill(themeManager.currentTheme.colors.background.opacity(0.8))
                .frame(width: 52, height: 52)

            Circle()
                .trim(from: 0, to: CGFloat(rating / 100))
                .stroke(themeManager.currentTheme.colors.primary.opacity(0.4), lineWidth: 6)
                .blur(radius: 2)
                .frame(width: 42, height: 42)
                .rotationEffect(.degrees(-90))

            Circle()
                .trim(from: 0, to: CGFloat(rating / 100))
                .stroke(themeManager.currentTheme.colors.primary, lineWidth: 3)
                .frame(width: 42, height: 42)
                .rotationEffect(.degrees(-90))

            Text("\(formattedRating)%")
                .font(.caption2)
                .bold()
                .foregroundColor(themeManager.currentTheme.colors.primary)
        }
    }
}
