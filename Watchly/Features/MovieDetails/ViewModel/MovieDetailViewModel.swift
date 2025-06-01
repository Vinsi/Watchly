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

    func fetchDetails() async {
        sections = .fetching
        do {
            let movieDetails = try await useCase.getDetails(id: movieID)
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
