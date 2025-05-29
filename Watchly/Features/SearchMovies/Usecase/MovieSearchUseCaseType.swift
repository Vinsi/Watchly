//
//  MovieSearchUseCaseType.swift
//
//
//  Created by Vinsi.
//

protocol MovieSearchUseCaseType {
    func search(query: String) async throws -> SearchResultsResponse
}

struct MovieSearchUseCaseImpl: MovieSearchUseCaseType {

    let service: SearchServiceType
    func search(query: String) async throws -> SearchResultsResponse {
        guard let response = try await service.search(query: query) else {
            throw AppError.emptyValue
        }
        return response
    }
}
