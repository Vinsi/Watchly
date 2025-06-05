//
//  TrendingMovieListView.swift
//
//
//  Created by Vinsi.
//
import SwiftUI
import TMDBCore

struct TrendingMovieListView: View {
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var environment: AppEnvironment
    @EnvironmentObject private var themeManager: ThemeManager
    @StateObject var viewModel: TrendingMovieListViewModel

    init(
        useCase: GetTrendingMoviesUseCaseType,
        onNavigation: ((TrendingMovieListViewModel.NavigationEvent) -> Void)? = nil
    ) {
        let viewModel = TrendingMovieListViewModel(useCase: useCase)
        viewModel.onNavigation = onNavigation
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {

        VStack {
            ZStack(alignment: .top) {
                ItemListView(
                    movies: viewModel.viewData,
                    onTap: viewModel.onSelect(_:),
                    onAppear5thLastElement: { [weak viewModel] in
                        Task { [weak viewModel] in
                            await viewModel?.loadMore()
                        }
                    }
                )

                if viewModel.pageIsLoading {
                    HUDLoaderView()
                        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                }
            }
            .background(AppBackground())
        }
        .refreshable {
            Task { [weak viewModel] in
                await viewModel?.loadFromStart()
            }
        }
        .onAppear {
            Task { [weak viewModel] in
                await viewModel?.initialFetch()
            }
        }
        .errorAlert(
            isPresented: $viewModel.isError,
            errorMessage: viewModel.errorMessage,
            retryAction: viewModel.retry
        )

        .tabItem {
            Label(Localized.homeTitle,
                  systemImage: themeManager.currentTheme.images.listSystemIcon)
        }
    }
}

#Preview {
    TrendingMovieListView(useCase: GetTrendingMoviesUseCaseImpl(service: MockTrendingMoviesListServiceImpl()))
        .environmentObject(AppEnvironment.shared)
        .environmentObject(Router())
        .environmentObject(ThemeManager())
}
