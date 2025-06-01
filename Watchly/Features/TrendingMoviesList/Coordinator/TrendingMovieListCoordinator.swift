//
//  TrendingMovieListCoordinator.swift
//
//
//  Created by Vinsi.
//

import SwiftUI
import TMDBCore

struct TrendingMovieListCoordinator: Coordinator {
    let environment: AppEnvironment
    private let useCase: GetTrendingMoviesUseCaseType

    init(environment: AppEnvironment) {
        self.environment = environment
        let network = NetworkProcesserTypeImpl()
        let service = TrendingMovieListServiceImpl(
            baseURLProvider: environment,
            tokenProvider: environment,
            network: network,
            cacheFacilitator: EndPointCacheFaciltator<TrendingMoviesEndPoint>()
        )
        useCase = GetTrendingMoviesUseCaseImpl(service: service)
    }

    func start() -> some View {
        TrendingMovieListView(useCase: useCase)
    }
}
