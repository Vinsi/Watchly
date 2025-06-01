//
//  FavoritesButton 2.swift
//  Watchly
//
//  Created by Vinsi on 01/06/2025.
//

import SwiftUI
import UIKit

final class FavoritesButton: UIButton {

    private var movieID: Int = 0
    private var themeManager: ThemeManager
    private var favouritesManager: FavouritesManager

    init(movieID: Int, themeManager: ThemeManager, favouritesManager: FavouritesManager) {
        self.movieID = movieID
        self.themeManager = themeManager
        self.favouritesManager = favouritesManager
        super.init(frame: .zero)
        configure()
        updateAppearance()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        addTarget(self, action: #selector(toggleFavorite), for: .touchUpInside)
        accessibilityIdentifier = "favorites_button"
    }

    private func updateAppearance() {
        let isFav = favouritesManager.isFavourite(movieID)
        let imageName = isFav ? "heart.fill" : "heart"
        let image = UIImage(systemName: imageName)
        setImage(image, for: .normal)
        tintColor = isFav ?
            themeManager.currentTheme.colors.primary.toUIColor :
            themeManager.currentTheme.colors.secondary.toUIColor
        accessibilityLabel = isFav ? "Remove from favorites" : "Add to favorites"
    }

    @objc private func toggleFavorite() {
        favouritesManager.toggle(movieID)
        updateAppearance()
    }
}

struct FavoritesButtonSwiftUI: UIViewRepresentable {
    let movieID: Int
    @EnvironmentObject var themeManager: ThemeManager
    @EnvironmentObject var favouriteManager: FavouritesManager

    func makeUIView(context: Context) -> FavoritesButton {
        let button = FavoritesButton(
            movieID: movieID,
            themeManager: themeManager,
            favouritesManager: favouriteManager
        )
        return button
    }

    func updateUIView(_ uiView: FavoritesButton, context: Context) {

        // If needed, reconfigure view when SwiftUI state updates
    }
}
