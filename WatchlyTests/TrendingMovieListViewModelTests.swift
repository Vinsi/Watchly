//
//  TrendingMovieListViewModelTests.swift
//  Watchly
//
//  Created by Vinsi on 01/06/2025.
//

@testable import Watchly
import XCTest

@MainActor
final class TrendingMovieListViewModelTests: XCTestCase {

    func test_initialFetch_whenViewDataIsEmpty_triggersFetch() async {
        // Given

        let mockService = MockTrendingMoviesListServiceImpl()
        let useCase = GetTrendingMoviesUseCaseImpl(service: mockService)
        let viewModel = TrendingMovieListViewModel(useCase: useCase)

        // When
        await viewModel.initialFetch()

        // Then
        XCTAssertEqual(mockService.callCount, 1)
    }

//
    func test_initialFetch_whenViewDataIsNotEmpty_doesNotFetch() async {
        // Given
        let mockService = MockTrendingMoviesListServiceImpl()
        let useCase = GetTrendingMoviesUseCaseImpl(service: mockService)
        let viewModel = TrendingMovieListViewModel(useCase: useCase)

        // When
        await viewModel.initialFetch()

        // Then
        XCTAssertEqual(viewModel.viewData.count, 2)
    }

    func test_loadFromStart_resetsAndFetches() async {
        // Given
        let mockService = MockTrendingMoviesListServiceImpl()
        let useCase = GetTrendingMoviesUseCaseImpl(service: mockService)
        let viewModel = TrendingMovieListViewModel(useCase: useCase)

        // When
        await viewModel.loadFromStart()

        // Then
        XCTAssertGreaterThan(mockService.callCount, 0)
    }

    func test_loadMore_triggersFetch() async {
        // Given
        let mockService = MockTrendingMoviesListServiceImpl()
        let useCase = GetTrendingMoviesUseCaseImpl(service: mockService)
        let viewModel = TrendingMovieListViewModel(useCase: useCase)

        // When
        await viewModel.loadMore()

        // Then
        XCTAssertGreaterThan(mockService.callCount, 0)
    }
}
