//
import SwiftUI

//  ImageLoader.swift
//
//
//  Created by Vinsi.
//
import TMDBCore
import UIKit

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
