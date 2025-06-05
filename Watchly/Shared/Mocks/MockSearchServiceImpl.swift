//
//  MockSearchServiceImpl.swift
//  Watchly
//
//  Created by Vinsi on 01/06/2025.
//
import TMDBCore

final class MockSearchServiceImpl: SearchServiceType {

    var shouldFail: Bool = false
    var stubbedResponse: SearchResultsResponse

    init(shouldFail: Bool = false, stubbedResponse: SearchResultsResponse = .stub()) {
        self.shouldFail = shouldFail
        self.stubbedResponse = stubbedResponse
    }

    func search(query: String, page: Int) async throws -> SearchResultsResponse? {
        if shouldFail {
            throw NSError(domain: "MockError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Mock failure"])
        }
        return stubbedResponse
    }
}

extension TrendingMoviesResponse {
    static func stub(
        page: Int = 1,
        results: [Movie] = [Movie].stub(),
        totalPages: Int = 1,
        totalResults: Int = 2
    ) -> TrendingMoviesResponse {
        TrendingMoviesResponse(page: page, results: results, totalPages: totalPages, totalResults: totalResults)
    }
}

final class MockTrendingMoviesListServiceImpl: TrendingMovieListServiceType {
    var shouldFail: Bool = false
    var callCount = 0
    var stubbedResponse: TrendingMoviesResponse = .init(page: 1, results: .stub(), totalPages: 1, totalResults: 1)

    init(
        shouldFail: Bool = false,
        stubbedResponse: TrendingMoviesResponse = .init(page: 1, results: .stub(), totalPages: 1, totalResults: 1)
    ) {
        self.shouldFail = shouldFail
        self.stubbedResponse = stubbedResponse
    }

    func getAll(page: Int, canUseCache: Bool) async throws -> TMDBCore.TrendingMoviesResponse {
        callCount += 1
        if shouldFail {
            throw NSError(domain: "MockError", code: 1, userInfo: [NSLocalizedDescriptionKey: "Mock failure"])
        }
        return stubbedResponse
    }
}
