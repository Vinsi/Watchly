//
//  RemoteImage.swift
//  Watchly
//
//  Created by Vinsi on 01/06/2025.
//
import SwiftUI

@ViewBuilder
func placeholderImage(theme: Theme) -> some View {
    Image(systemName: "photo")
        .foregroundColor(theme.colors.primary)
        .scaledToFill()
        .opacity(0.1)
}

struct RemoteImage<PlaceHolder: View>: View {
    @EnvironmentObject var themeManager: ThemeManager
    @StateObject private var loader = ImageLoader()
    @State private var isVisible = false
    let url: URL?
    var placeholder: PlaceHolder

    init(url: URL?, @ViewBuilder placeholder: () -> PlaceHolder) {
        self.url = url
        self.placeholder = placeholder()
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
                placeholder
                    .overlay {
                        LoaderView(color:
                            DefaultTheme()
                                .colors
                                .primary
                        )
                    }
            } else if case .notStarted = loader.state {
                EmptyView()

            } else if case .completed = loader.state {
                if loader.image == nil {
                    placeholder
                }
            }
        }
        .onAppear {
            loader.loadImage(from: url)
        }.onDisappear {
            loader.cancel()
        }
    }
}
