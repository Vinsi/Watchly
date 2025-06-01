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
    private let useCase: MovieSearchUseCaseType

    init(environment: AppEnvironment) {
        self.environment = environment
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
        SearchView(useCase: useCase)
    }
}
