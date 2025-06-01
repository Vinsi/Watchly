//
//  MockMovieDetailsServiceImpl.swift
//  Watchly
//
//  Created by Vinsi on 01/06/2025.
//

import TMDBCore

final class MockMovieDetailsServiceImpl: MovieDetailsServiceType {

    var shouldFail: Bool = false
    var stubbedDetails: MovieDetails = .stub(id: 1)

    func getDetails(movieID: Int) async throws -> MovieDetails {
        if shouldFail {
            throw NSError(domain: "MockError", code: -1, userInfo: [NSLocalizedDescriptionKey: "Mock failure"])
        }
        return stubbedDetails
    }
}
