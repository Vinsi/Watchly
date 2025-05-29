//
//  TrendingMovieListView.swift
//
//
//  Created by Vinsi.
//
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
        NavigationView {
            VStack {
                ZStack(alignment: .top) {
                    MoviesListView(
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
            .navigationTitle(Localized.homeTitle)
            .navigationBarTitleDisplayMode(.inline)
            .onChange(of: viewModel.navigation, perform: { event in
                switch event {
                case .details:
                    router.navigate(to: .details(id: 12))
                case .none:
                    break
                }
            })
            .onAppear {
                viewModel.initialFetch()
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
