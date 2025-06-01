//
//  MockBreadListServiceType.swift
//
//
//  Created by Vinsi.
//

import TMDBCore

struct MockTrendingMoviesListServiceType: TrendingMovieListServiceType {
    func getAll(page: Int, canUseCache: Bool) async throws -> TMDBCore.TrendingMoviesResponse {
        action()
    }

    private let action: () -> TrendingMoviesResponse
    init(onExecute: @escaping () -> TrendingMoviesResponse = { .mock() }) {
        action = onExecute
    }
}

extension TrendingMoviesResponse {
    static func mock(
        page: Int = 0,
        totalPage: Int = 0,
        totalResults: Int = [Movie].mock().count,
        results: [Movie] = .mock()
    ) -> Self {
        TrendingMoviesResponse(page: 0, results: results, totalPages: totalResults, totalResults: totalResults)
    }
}

extension [Movie] {
    static func mock() -> [Movie] {
        [
            .mock(),
            .mock(id: 2),
        ]
    }
}
