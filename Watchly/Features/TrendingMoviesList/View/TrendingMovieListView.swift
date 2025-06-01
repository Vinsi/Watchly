//
//  TrendingMovieListView.swift
//
//
//  Created by Vinsi.
//
import TMDBCore

let logPaging = LogWriter(.init(value: "List"))
let log = LogWriter(.init(value: "TMDB"))
let logNet = LogWriter(.init(value: "Net"))

import SwiftUI

struct TrendingMovieListView: View {
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var environment: AppEnvironment
    @EnvironmentObject private var themeManager: ThemeManager
    @StateObject var viewModel: TrendingMovieListViewModel
    var onTap: ((ListViewDataType) -> Void)?

    init(useCase: GetTrendingMoviesUseCaseType, onTap: ((ListViewDataType) -> Void)? = nil) {
        _viewModel = StateObject(wrappedValue: TrendingMovieListViewModel(useCase: useCase))
        self.onTap = onTap
    }

    var body: some View {

        VStack {
            ZStack(alignment: .top) {
                ItemListView(
                    movies: viewModel.viewData,
                    onTap: viewModel.onSelect(_:),
                    onAppear5thLastElement: { [weak viewModel] in
                        viewModel?.loadMore()
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
            viewModel.loadFromStart()
        }
        .onAppear {
            viewModel.initialFetch()
        }
        .task {
            viewModel.setNavigationEventCallBack { [weak router] event in
                switch event {
                case .details(let movieID):
                    router?.navigate(to: .details(id: movieID))
                }
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
    TrendingMovieListView(useCase: GetTrendingMoviesUseCaseImpl(service: MockTrendingMoviesListServiceType()))
        .environmentObject(AppEnvironment.shared)
        .environmentObject(Router())
        .environmentObject(ThemeManager())
}
