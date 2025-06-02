//
//  TMDBRemoteImage.swift
//  Watchly
//
//  Created by Vinsi on 01/06/2025.
//

import SwiftUI
import TMDBCore

struct TMDBRemoteImage<PlaceHolder: View>: View {
    @EnvironmentObject var themeManager: ThemeManager
    @StateObject private var loader = TMDBImageDownloader()
    @State private var isVisible = false
    let url: TMDBImage?
    let placeholder: PlaceHolder
    init(url: TMDBImage?, @ViewBuilder placeholder: () -> PlaceHolder) {
        self.url = url
        self.placeholder = placeholder()
    }

    @ViewBuilder func loaderPlaceholder() -> some View {
        placeholder
            .overlay {
                LoaderView(color:
                    DefaultTheme()
                        .colors
                        .primary
                )
            }
    }

    var body: some View {
        ZStack {
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .opacity(isVisible ? 1 : 0) // Start at 0 opacity
                    .animation(.easeIn(duration: 1), value: isVisible)
                    .onAppear {
                        isVisible = true // Triggers animation
                    }
            } else if case .loading = loader.state {
                loaderPlaceholder()

            } else if case .notStarted = loader.state {
                loaderPlaceholder()
            }
        }
        .onAppear {
            loader.loadImage(from: url)
        }.onDisappear {
            loader.cancel()
        }
    }
}
