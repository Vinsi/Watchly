//
//  SearchMoviesCoordinator.swift
//
//
//  Created by Vinsi.
//

import SwiftUI
import TMDBCore

struct SearchMoviesCoordinator: Coordinator {
    let environment: AppEnvironment
    let router: Router

    private let useCase: MovieSearchUseCaseType

    init(environment: AppEnvironment, router: Router) {
        self.environment = environment
        self.router = router
        let network = NetworkProcesserTypeImpl()
        let service = MovieSearchServiceImpl(
            network: network,
            baseURLProvider: environment,
            tokenProvider: environment,
            cacheFacilitator: EndPointCacheFaciltator<SearchMoviesEndPoint>()
        )
        useCase = MovieSearchUseCaseImpl(service: service)
    }

    func start() -> some View {
        SearchView(useCase: useCase, onNavigationEvent: routing(navigationEvent:))
    }

    func routing(navigationEvent: SearchViewModel.NavigationEvent) {
        if case .detail(let id) = navigationEvent {
            router.navigate(to: .details(id: id))
        }
    }
}
