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
    private var onNavigation: ((NavigationEvent) -> Void)?

    private(set) var errorMessage: String?

    /// 📌 **Dependencies**
    private let useCase: GetTrendingMoviesUseCaseType

    /// 📖 **Pagination Setup**
    private let pageSize = 20
    lazy var pagingManager = PagingManager<TrendingMovieListViewModel>(viewModel: self, pageSize: pageSize)

    init(useCase: GetTrendingMoviesUseCaseType) {
        self.useCase = useCase
    }

    func loadFromStart() {
        pagingManager.reset()
        Task { [weak self] in
            await self?.fetch()
        }
    }

    func initialFetch() {
        guard viewData.isEmpty else {
            return
        }
        pagingManager.reset()
        Task { [weak self] in
            await self?.fetch()
        }
    }

    func loadMore() {
        Task { [weak self] in
            await self?.fetch()
        }
    }

    func onSelect(_ viewData: ListViewDataType) {
        onNavigation?(.details(id: viewData.movieID))
    }

    @MainActor
    private func fetch() {
        Task { [weak self] in
            do {
                self?.hideError()
                try await self?.pagingManager.fetchNextPage()
            } catch {
                self?.errorMessage = error.localizedDescription
                self?.showError()
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

    func setNavigationEventCallBack(on callback: @escaping (NavigationEvent) -> Void) {
        onNavigation = callback
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
        viewData.append(contentsOf: items)
    }

    func reset() {
        viewData.removeAll()
    }
}
