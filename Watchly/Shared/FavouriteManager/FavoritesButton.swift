//
//  FavoritesButton.swift
//  Watchly
//
//  Created by Vinsi on 30/05/2025.
//

import SwiftUI

struct FavoritesButton: View {
    let movieID: Int
    @EnvironmentObject var themeManager: ThemeManager
    @EnvironmentObject var favouriteManager: FavouritesManager

    var body: some View {
        Button(action: {
            favouriteManager.toggle(movieID)
        }) {
            Image(systemName: favouriteManager.isFavourite(movieID) ? "heart.fill" : "heart")
                .foregroundColor(favouriteManager.isFavourite(movieID) ? themeManager.currentTheme.colors.primary : themeManager.currentTheme.colors.secondary)
                .imageScale(.large)
                .padding()
        }
        .accessibilityLabel(favouriteManager.isFavourite(movieID) ? "Remove from favorites" : "Add to favorites")
    }
}
