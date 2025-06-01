//
//  TMDBRemoteImage.swift
//  Watchly
//
//  Created by Vinsi on 01/06/2025.
//

import SwiftUI
import TMDBCore

struct TMDBRemoteImage: View {
    @StateObject private var loader = TMDBImageDownloader()
    @State private var isVisible = false
    let url: TMDBImage?
    let placeholder: Image

    init(url: TMDBImage?, placeholder: Image = Image(systemName: "photo")) {
        self.url = url
        self.placeholder = placeholder
    }

    @ViewBuilder func loaderPlaceholder() -> some View {
        placeholder
            .resizable()
            .scaledToFit()
            .opacity(0.2)
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .clipped()
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
