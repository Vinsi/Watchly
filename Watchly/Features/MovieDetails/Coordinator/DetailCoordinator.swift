//
//  DetailCoordinator.swift
//
//
//  Created by Vinsi on 16/05/2025.
//

import SwiftUI
import TMDBCore

struct DetailCoordinator: Coordinator {
    let environment: AppEnvironment
    let movieID: Int

    func start() -> some View {
        let network = NetworkProcesserTypeImpl()
        let service = MovieDetailsServiceTypeImpl(
            network: network,
            baseURLProvider: environment,
            tokenProvider: environment,
            cachefacilitator: EndPointCacheFaciltator(cache: CacheManager.shared.movieDetailsResponseCache)
        )
        let useCase = DetailUseCaseImpl(service: service)
        return MovieDetailView(useCase: useCase, movieID: movieID)
    }
}
