//
//  TMDBImageDownloader.swift
//  Watchly
//
//  Created by Vinsi on 01/06/2025.
//
import TMDBCore
import UIKit

final class TMDBImageDownloader: ObservableObject {

    enum State {
        case notStarted
        case loading
        case failed(Error)
        case completed
    }

    @Published var image: UIImage?
    @Published var state = State.notStarted
    private var downloadTask: Task<Void, Never>? // Task for the current image download
    // swiftlint:disable function_body_length
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

    // swiftlint:enable function_body_length

    func cancel() {
        downloadTask?.cancel()
        downloadTask = nil
        state = .notStarted
    }
}
