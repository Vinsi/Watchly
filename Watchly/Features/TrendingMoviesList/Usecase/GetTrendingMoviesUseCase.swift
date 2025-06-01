//
//  GetTrendingMoviesUseCase.swift
//
//
//  Created by Vinsi on 15/05/2025.
//

import TMDBCore

protocol GetTrendingMoviesUseCaseType {
    func fetch(page: Int, canUseCache: Bool) async throws -> TrendingMoviesResponse
}

struct GetTrendingMoviesUseCaseImpl: GetTrendingMoviesUseCaseType {
    let service: TrendingMovieListServiceType
    func fetch(page: Int, canUseCache: Bool) async throws -> TrendingMoviesResponse {
        try await service.getAll(page: page, canUseCache: canUseCache)
    }
}
