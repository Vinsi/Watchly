////
////  MovieDetailViewModel.swift
////
////
////  Created by Vinsi.
////

import Foundation

///  **ViewModel for Movie Details Screen**
/// - Handles fetching images, preparing attributes, and managing UI state.
/// - Uses `DataState` to track loading, success, and failure states.

@MainActor
final class MovieDetailViewModel: ObservableObject {

    /// 🔄 **Published State**: Holds the current state of detail sections.
    @Published var sections: DataState<[DetailSection], any Error> = .notStarted

    /// 🐾 **Breed Information**
    let movieID: Int

    /// 📸 **Service to Fetch Breed Images**
    let useCase: DetailUseCaseType

    init(useCase: DetailUseCaseType, movieID: Int) {
        self.useCase = useCase
        self.movieID = movieID
    }

    func fetchDetails() {
        sections = .fetching
        Task { [weak self] in
            guard let self else { return }
            do {
                let movieDetails = try await useCase.getDetails(id: self.movieID)
                await MainActor.run {
                    self.sections = .success(movieDetails)
                }
            } catch {
                await MainActor.run {
                    self.sections = .failure(error)
                }
            }
        }
    }
}

extension Double {
    func asStarRating(maxStars: Int = 10) -> String {

        let fullStars = Int(self)
        let fractional = self - Double(fullStars)

        let halfStar = fractional >= 0.75 ? 1 : (fractional >= 0.25 ? 0.5 : 0.0)
        let filledStars = fullStars + (halfStar == 1 ? 1 : 0)
        let halfStars = halfStar == 0.5 ? 1 : 0
        let emptyStars = maxStars - filledStars - halfStars

        return String(repeating: "★", count: filledStars)
            + String(repeating: "☆", count: halfStars) // substitute for half star
            + String(repeating: "☆", count: emptyStars)
    }
}
