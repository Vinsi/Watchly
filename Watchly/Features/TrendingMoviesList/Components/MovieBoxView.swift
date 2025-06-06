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
    var body: some View {
        VStack(alignment: .leading, spacing: themeManager.currentTheme.spacing.small) {

            ZStack(alignment: .bottomLeading) {

                RemoteImage(url: posterURL, placeholder: { placeholderImage(theme: themeManager.currentTheme) })
                    .frame(height: themeManager.currentTheme.dimensions.cardHeight)
                    .clipped()
                if rating != 0 {
                    RatingBadgeView(rating: rating).offset(
                        x: themeManager.currentTheme.spacing.large,
                        y: themeManager.currentTheme.spacing.large
                    )
                }
            }

            VStack(alignment: .leading) {
                HStack {

                    Text(title)
                        .font(.headline)
                        .lineLimit(2)
                        .fixedSize(horizontal: false, vertical: true)
                        .foregroundColor(themeManager.currentTheme.colors.textPrimary)

                    Spacer()
                }

                HStack {
                    Text(releaseDate ?? "")
                        .font(.subheadline)
                        .foregroundColor(themeManager.currentTheme.colors.textSecondary)
                    Spacer()
                }

                Spacer().frame(minHeight: 0)
            }
            .padding(.top, 20)
            .padding([.horizontal, .bottom], themeManager.currentTheme.spacing.small)
        }

        .clipShape(RoundedRectangle(cornerRadius: themeManager.currentTheme.dimensions.cornerRadius))
        .background(
            RoundedRectangle(cornerRadius: themeManager.currentTheme.dimensions.cornerRadius)
                .fill(themeManager.currentTheme.colors.secondary)
                .shadow(color: themeManager.currentTheme.colors.primary.opacity(0.2), radius: 2)
        )
    }
}

#Preview {
    MovieBoxView(
        posterURL: URL(string: "https://image.tmdb.org/t/p/w500/mKKqV23MQ0uakJS8OCE2TfV5jNS.jpg"),
        title: "Final Destination Bloodlines (2025)",
        releaseDate: "May 21, 2025",
        rating: 71
    )
    .frame(width: 160)
    .environmentObject(ThemeManager())
}
