//
//  TrendingMovieListViewModel.swift
//
//
//  Created by Vinsi.
//
import Foundation
import TMDBCore

/// 🐱 **ViewModel for Managing Movie List**
/// - Handles data fetching, pagination, and error states.
/// - Uses `PagingManager` to support paginated API calls.

final class TrendingMovieListViewModel: ObservableObject {

    enum NavigationEvent: Equatable {
        case details(id: Int)
    }

    /// 🏗 **Published Properties for UI Updates**
    @Published var pageIsLoading = false
    @Published private(set) var viewData: [ListViewDataType] = []

    @Published var isError: Bool = false
    var onNavigation: ((NavigationEvent) -> Void)?

    private(set) var errorMessage: String?

    /// 📌 **Dependencies**
    private let useCase: GetTrendingMoviesUseCaseType

    /// 📖 **Pagination Setup**
    private let pageSize = 20
    lazy var pagingManager = PagingManager<TrendingMovieListViewModel>(viewModel: self, pageSize: pageSize)

    init(useCase: GetTrendingMoviesUseCaseType) {
        self.useCase = useCase
    }

    func loadFromStart() async {
        pagingManager.reset()
        await fetch()
    }

    func initialFetch() async {
        guard viewData.isEmpty else {
            return
        }
        await MainActor.run {
            pagingManager.reset()
        }
        await fetch()
    }

    func loadMore() async {
        await fetch()
    }

    func onSelect(_ viewData: ListViewDataType) {
        onNavigation?(.details(id: viewData.movieID))
    }

    private func fetch() async {
        do {
            await hideError()
            try await pagingManager.fetchNextPage()
        } catch {
            await MainActor.run {
                errorMessage = error.localizedDescription
                showError()
            }
        }
    }

    /// 🔄 **Retry Fetching After Failure**
    /// - Resets loading state and attempts to fetch again.
    func retry() {
        pageIsLoading = false
        Task { [weak self] in
            await self?.fetch()
        }
    }

    @MainActor
    private func showError() {
        isError = true
    }

    @MainActor
    private func hideError() {
        isError = false
    }
}

extension TrendingMovieListViewModel: Paginatable {

    /// 📦 **Fetches a Page of  trending movies**
    /// - Parameters:
    ///   - page: Page number to fetch.
    ///   - size: Number of items per page.
    /// - Returns: A list of `movies` objects.
    /// - Throws: If the request fails.
    func fetchPage(page: Int, size: Int) async throws -> [Movie] {
        return try await useCase.fetch(page: page, canUseCache: true).results
    }

    /// ➕ **Adds New Items to ViewData**
    /// - Appends fetched movies to the list.
    func add(items: [Movie]) {
        var newFilteredItems = items
        if let movies = viewData as? [Movie] {
            newFilteredItems = Array(Set(items).subtracting(movies))
        }
        viewData.append(contentsOf: newFilteredItems)
    }

    func reset() {
        viewData.removeAll()
    }
}

extension Movie: @retroactive Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
