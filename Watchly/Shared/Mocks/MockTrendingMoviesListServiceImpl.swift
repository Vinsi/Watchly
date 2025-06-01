//
//  MockTrendingMoviesListServiceImpl.swift
//
//
//  Created by Vinsi.
//

import TMDBCore

extension TrendingMoviesResponse {
    static func stub(
        page: Int = 1,
        totalPage: Int = 0,
        totalResults: Int = [Movie].stub().count,
        results: [Movie] = [Movie].stub()
    ) -> TrendingMoviesResponse {
        TrendingMoviesResponse(page: page, results: results, totalPages: totalResults, totalResults: totalResults)
    }
}

extension [Movie] {
    static func stub() -> [Movie] {
        [
            .stub(),
            .stub(id: 2),
        ]
    }
}
