//
//  SearchViewModel.swift
//
//
//  Created by Vinsi.
//

import Foundation

@MainActor
final class SearchViewModel: ObservableObject {
    enum NavigationEvent: Equatable {
        case detail(movieID: Int)
    }

    @Published private(set) var dataState: DataState<[ListViewDataType], any Error> = .notStarted
    @Published var isLoading: Bool = false
    @Published var searchText: String = "" {
        didSet {
            log.logI("search.text.query?\(searchText)")
            search(searchText)
        }
    }

    @Published var navigation: NavigationEvent?
    private let useCase: MovieSearchUseCaseType
    private let debouncer = AsyncDebouncer<String, [Movie]>(delay: 0.3)

    init(useCase: MovieSearchUseCaseType) {
        self.useCase = useCase

        debouncer.config { [weak self] in
            self?.isLoading = $0
        }

        debouncer.config(operation: { [weak self] query in
            let list = try await self?.useCase.search(query: query).results ?? []
            return list
        })
    }

    func search(_ query: String) {
        log.logI("search.started")
        debouncer.debounce(input: query) { [weak self] result in
            switch result {
            case .success(let movies):
                self?.dataState = .success(movies)
            case .failure(let error):
                self?.dataState = .failure(AppError.from(error))
            }
        }
    }

    @MainActor
    func loader(isShowing: Bool = true) {
        isLoading = isLoading
    }

    func retry() {
        search(searchText)
    }

    func onSelect(_ viewData: ListViewDataType) {
        navigation = .detail(movieID: viewData.movieID)
    }
}
