//
//  SearchMoviesCoordinator.swift
//
//
//  Created by Vinsi.
//

import SwiftUI

struct SearchMoviesCoordinator: Coordinator {
    let environment: AppEnvironment
    private let useCase: MovieSearchUseCaseType

    init(environment: AppEnvironment) {
        self.environment = environment
        let network = NetworkProcesserTypeImpl()
        let service = MovieSearchServiceImpl(network: network, baseURLProvider: environment, tokenProvider: environment)
        useCase = MovieSearchUseCaseImpl(service: service)
    }

    func start() -> some View {
        SearchView(useCase: useCase)
    }
}
