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
    private let languageManager: LanguageManager
    init(environment: AppEnvironment, router: Router, languageManager: LanguageManager) {
        self.environment = environment
        self.router = router
        self.languageManager = languageManager
        let network = NetworkProcesserTypeImpl()
        let service = MovieSearchServiceImpl(
            network: network,
            baseURLProvider: environment,
            tokenProvider: environment,
            cacheFacilitator: EndPointCacheFaciltator<SearchMoviesEndPoint>(),
            language: languageManager
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
