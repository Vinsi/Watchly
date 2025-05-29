//
//  TrendingMovieListCoordinator.swift
//
//
//  Created by Vinsi.
//

import SwiftUI

struct TrendingMovieListCoordinator: Coordinator {
    let environment: AppEnvironment
    private let useCase: GetTrendingMoviesUseCaseType

    init(environment: AppEnvironment) {
        self.environment = environment
        let network = NetworkProcesserTypeImpl()
        let service = TrendingMovieListServiceImpl(
            baseURLProvider: environment,
            tokenProvider: environment,
            network: network
        )
        useCase = GetTrendingMoviesUseCaseImpl(service: service)
    }

    func start() -> some View {
        TrendingMovieListView(useCase: useCase)
    }
}
