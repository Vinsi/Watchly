//
//  RemoteImage.swift
//  Watchly
//
//  Created by Vinsi on 01/06/2025.
//
import SwiftUI

struct RemoteImage: View {
    @StateObject private var loader = ImageLoader()
    @State private var isVisible = false
    let url: URL?
    let placeholder: Image

    init(url: URL?, placeholder: Image = Image(systemName: "photo")) {
        self.url = url
        self.placeholder = placeholder
    }

    var body: some View {
        VStack {
            if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .opacity(isVisible ? 1 : 0) // Start at 0 opacity
                    .animation(.easeIn(duration: 1), value: isVisible)
                    .onAppear {
                        isVisible = true // Triggers animation
                    }
            } else if case .loading = loader.state {
                LoaderView(color:
                    DefaultTheme()
                        .colors
                        .primary
                )
            } else if case .notStarted = loader.state {
                EmptyView()

            } else if case .completed = loader.state {
                placeholder
                    .resizable()
                    .scaledToFill()
                    .opacity(0.5)
            }
        }
        .onAppear {
            loader.loadImage(from: url)
        }.onDisappear {
            loader.cancel()
        }
    }
}
