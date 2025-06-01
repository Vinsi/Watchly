//
import SwiftUI

//  ImageLoader.swift
//
//
//  Created by Vinsi.
//
import TMDBCore
import UIKit

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

final class ImageLoader: ObservableObject {

    enum State {
        case notStarted
        case loading
        case completed
    }

    @Published var image: UIImage?
    @Published var state = State.notStarted
    private var downloadTask: Task<Void, Never>? // Task for the current image download

    func loadImage(from url: URL?) {
        guard let url = url else { return }
        let cacheKey = url.absoluteString

        // Cancel any existing task
        downloadTask?.cancel()

        // Start a new task
        downloadTask = Task {
            // Check cache first
            if let cachedImage = await CacheManager.shared.imageCache.getValue(forKey: cacheKey) {
                DispatchQueue.main.async {
                    self.image = cachedImage
                }
                return
            }

            // Download the image
            DispatchQueue.main.async {
                self.state = .loading
            }
            do {
                let (data, _) = try await URLSession.shared.data(from: url)
                guard !Task.isCancelled else { return } // Handle cancellation

                if let loadedImage = UIImage(data: data) {
                    await CacheManager.shared.imageCache.setValue(loadedImage, forKey: cacheKey)
                    DispatchQueue.main.async {
                        self.image = loadedImage
                    }
                }
            } catch {
                print("Failed to load image: \(error)")
            }

            DispatchQueue.main.async {
                self.state = .completed
            }
        }
    }

    func cancel() {
        downloadTask?.cancel()
        downloadTask = nil
        state = .notStarted
    }
}

struct TMDBRemoteImage: View {
    @StateObject private var loader = TmdbImageLoader()
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

final class TmdbImageLoader: ObservableObject {

    enum State {
        case notStarted
        case loading
        case failed(Error)
        case completed
    }

    @Published var image: UIImage?
    @Published var state = State.notStarted
    private var downloadTask: Task<Void, Never>? // Task for the current image download
    // swiftlint disable function_body_length
    func loadImage(from imagePath: TMDBImage?) {
        guard let lowResolutionURL = imagePath?.getImageURL(size: .w92),
              let highResolutionURL = imagePath?.getImageURL(size: .original)
        else {
            return
        }

        let lowCacheKey = lowResolutionURL.absoluteString
        let highCacheKey = highResolutionURL.absoluteString

        // Cancel previous task if any
        downloadTask?.cancel()

        downloadTask = Task {
            await MainActor.run {
                self.state = .loading
            }
            // 1. Check high-resolution cache first
            if let cachedHigh = await CacheManager.shared.imageCache.getValue(forKey: highCacheKey) {
                await MainActor.run {
                    self.image = cachedHigh
                    self.state = .completed
                }
                return
            }

            // 2. Check low-resolution cache
            var showedLow = false
            if let cachedLow = await CacheManager.shared.imageCache.getValue(forKey: lowCacheKey) {
                await MainActor.run {
                    self.image = cachedLow
                }
                showedLow = true
            }

            do {
                // 3. Start both downloads concurrently
                async let highResult = URLSession.shared.data(from: highResolutionURL)
                async let lowResult = URLSession.shared.data(from: lowResolutionURL)

                // If no low-res shown yet, download and show it first
                if !showedLow {
                    let (lowData, _) = try await lowResult
                    if let lowImage = UIImage(data: lowData) {
                        await CacheManager.shared.imageCache.setValue(lowImage, forKey: lowCacheKey)
                        await MainActor.run {
                            self.image = lowImage
                        }
                    }
                }

                // Download and show high-res
                let (highData, _) = try await highResult
                if Task.isCancelled { return }

                if let highImage = UIImage(data: highData) {
                    await CacheManager.shared.imageCache.setValue(highImage, forKey: highCacheKey)
                    await MainActor.run {
                        self.image = highImage
                        self.state = .completed
                    }
                }
            } catch {
                if Task.isCancelled { return }
                await MainActor.run {
                    self.state = .failed(error)
                }
            }
        }
    }

    // swiftlint enable function_body_length

    func cancel() {
        downloadTask?.cancel()
        downloadTask = nil
        state = .notStarted
    }
}
