//
//  SearchResultsResponse.swift
//  Watchly
//
//  Created by Vinsi on 28/05/2025.
//

// MARK: - SearchResultsResponse

struct SearchResultsResponse: Codable {
    let page: Int
    let results: [Movie]
    let totalPages: Int
    let totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}
