//
//  GetTrendingMoviesUseCase.swift
//
//
//  Created by Vinsi on 15/05/2025.
//

protocol GetTrendingMoviesUseCaseType {
    func fetch(page: Int) async throws -> TrendingMoviesResponse
}

struct GetTrendingMoviesUseCaseImpl: GetTrendingMoviesUseCaseType {
    let service: TrendingMovieListServiceType
    func fetch(page: Int) async throws -> TrendingMoviesResponse {
        try await service.getAll(page: page)
    }
}
