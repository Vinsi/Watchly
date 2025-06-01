//
//  MovieDetailViewModelTests.swift
//  Watchly
//
//  Created by Vinsi on 01/06/2025.
//

@testable import Watchly
import XCTest

@MainActor
final class MovieDetailViewModelTests: XCTestCase {

    func test_fetchDetails_success_setsSectionsToSuccess() async {
        // Given
        let mockService = MockMovieDetailsServiceImpl()
        mockService.stubbedDetails = .stub()
        let viewModel = MovieDetailViewModel(
            useCase: DetailUseCaseImpl(service: mockService),
            movieID: 1
        )

        // When
        await viewModel.fetchDetails()

        // Then
        switch viewModel.sections {
        case .success(let details):
            XCTAssertEqual(details.count, 6, "Expected 6 detail sections.")
            let ids = details.map(\.id)
            XCTAssertEqual(ids, [
                "backdrop", "posterimage", "overview", "genres", "details", "link",
            ], "Section IDs should match expected order.")
        default:
            XCTFail("Expected success, but got \(viewModel.sections)")
        }
    }

    func test_fetchDetails_failure_setsSectionsToFailure() async {
        // Given
        let mockService = MockMovieDetailsServiceImpl()
        mockService.stubbedDetails = .stub()
        mockService.shouldFail = true

        let viewModel = MovieDetailViewModel(
            useCase: DetailUseCaseImpl(service: mockService),
            movieID: 1
        )

        // When
        await viewModel.fetchDetails()

        // Then
        switch viewModel.sections {
        case .failure(let error):
            XCTAssertNotNil(error, "Expected error to be non-nil")
        default:
            XCTFail("Expected failure, but got \(viewModel.sections)")
        }
    }
}
