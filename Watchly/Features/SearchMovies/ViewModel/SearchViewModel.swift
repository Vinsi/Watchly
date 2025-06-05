//
//  SearchViewModel.swift
//
//
//  Created by Vinsi.
//

import Foundation
import TMDBCore

final class SearchViewModel: ObservableObject {

    enum NavigationEvent: Equatable {
        case detail(movieID: Int)
    }

    @Published private(set) var dataState: DataState<[ListViewDataType], any Error> = .notStarted
    @Published var pageIsLoading: Bool = false
    @Published var searchText: String = "" {
        didSet {
            search(searchText)
        }
    }

    private let useCase: MovieSearchUseCaseType
    /// 📖 **Pagination Setup**
    private let pageSize = 20
    @Published private(set) var viewData: [ListViewDataType] = []
    lazy var pagingManager = PagingManager<SearchViewModel>(viewModel: self, pageSize: pageSize)
    private var query: String = ""
    private let debouncer = AsyncDebouncer<String, [ListViewDataType]>(delay: 0.3)
    var navigationEventCallBack: ((NavigationEvent) -> Void)?

    init(useCase: MovieSearchUseCaseType) {
        self.useCase = useCase

        debouncer.config { [weak self] in
            self?.pageIsLoading = $0
        }

        debouncer.config(operation: { [weak self] _ in
            await MainActor.run { [weak self] in
                self?.pagingManager.reset()
            }
            try await self?.pagingManager.fetchNextPage()
            return self?.viewData ?? []
        })
    }

    func search(_ query: String) {
        self.query = query
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
        pageIsLoading = isShowing
    }

    func retry() {
        search(searchText)
    }

    func onSelect(_ viewData: ListViewDataType) {
        navigationEventCallBack?(.detail(movieID: viewData.movieID))
    }
}

extension SearchViewModel: Paginatable {

    /// 📦 **Fetches a Page of  trending movies**
    /// - Parameters:
    ///   - page: Page number to fetch.
    ///   - size: Number of items per page.
    /// - Returns: A list of `movies` objects.
    /// - Throws: If the request fails.
    func fetchPage(page: Int, size: Int) async throws -> [ListViewDataType] {
        let list = try await useCase.search(query: query, page: page).results
        return list
    }

    /// ➕ **Adds New Items to ViewData**
    /// - Appends fetched movies to the list.
    func add(items: [ListViewDataType]) {
        var newFilteredItems = items as? [Movie] ?? []
        if let movies = viewData as? [Movie] {
            newFilteredItems = Array(Set(newFilteredItems).subtracting(movies))
        }
        viewData.append(contentsOf: newFilteredItems)
    }

    func reset() {
        viewData.removeAll()
    }
}

protocol NavigationSupportable: AnyObject {
    var navigationEventCallBack: ((NavigationEvent) -> Void)? { get set }
    associatedtype NavigationEvent: Equatable
}
