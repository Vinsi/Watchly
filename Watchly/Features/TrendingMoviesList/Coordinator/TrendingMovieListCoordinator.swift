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
    let router: Router
    private let useCase: GetTrendingMoviesUseCaseType

    init(environment: AppEnvironment, router: Router) {
        self.environment = environment
        self.router = router
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
        TrendingMovieListView(useCase: useCase, onNavigation: routing(navigationEvent:))
    }

    func routing(navigationEvent: TrendingMovieListViewModel.NavigationEvent) {
        if case .details(let id) = navigationEvent {
            router.navigate(to: .details(id: id))
        }
    }
}
