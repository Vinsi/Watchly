//
//  MovieBoxView.swift
//  Watchly
//
//  Created by Vinsi on 31/05/2025.
//

import SwiftUI

struct MovieBoxView: View {
    @EnvironmentObject var themeManager: ThemeManager
    let posterURL: URL?
    let title: String
    let releaseDate: String?
    let rating: Double
    let width: CGFloat
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {

            ZStack(alignment: .bottomLeading) {
                RemoteImage(url: posterURL, placeholder: { placeholderImage(theme: themeManager.currentTheme) })
                    .frame(height: themeManager.currentTheme.dimensions.cardHeight)
                    .frame(width: width * 0.95)
                    .clipped()
                if rating != 0 {
                    RatingBadgeView(rating: rating).offset(
                        x: themeManager.currentTheme.spacing.large,
                        y: themeManager.currentTheme.spacing.large
                    )
                }
            }
            VStack(alignment: .leading) {

                Text(title)
                    .font(.headline)
                    .truncationMode(.tail)
                    .lineLimit(1)
                    .foregroundColor(.primary)

                Text(releaseDate ?? "")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            .frame(width: width - 2 * 16)
            .padding(.top, 20)
            .padding([.horizontal, .bottom], 8)
        }

        .clipShape(RoundedRectangle(cornerRadius: 16))
        .background(
            RoundedRectangle(cornerRadius: themeManager.currentTheme.dimensions.cornerRadius)
                .fill(Color.white)
                .shadow(color: themeManager.currentTheme.colors.primary.opacity(0.2), radius: 2)
        )

        .frame(height: themeManager.currentTheme.dimensions.movieBoxHeight)
    }
}

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

#Preview {
    MovieBoxView(
        posterURL: URL(string: "https://image.tmdb.org/t/p/w500/mKKqV23MQ0uakJS8OCE2TfV5jNS.jpg"),
        title: "Final Destination Bloodlines (2025)",
        releaseDate: "May 21, 2025",
        rating: 71,
        width: 120
    )
    .frame(width: 160)
    .environmentObject(ThemeManager())
}
