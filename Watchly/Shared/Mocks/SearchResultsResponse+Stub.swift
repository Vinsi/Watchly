//
//  SearchResultsResponse+Stub.swift
//  Watchly
//
//  Created by Vinsi on 01/06/2025.
//

import TMDBCore

extension SearchResultsResponse {
    static func stub(
        page: Int = 1,
        results: [Movie] = .stub(),
        totalPages: Int = 1,
        totalResults: Int = 2
    ) -> SearchResultsResponse {
        SearchResultsResponse(page: page, results: results, totalPages: totalPages, totalResults: totalResults)
    }
}
