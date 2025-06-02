//
//  SearchView.swift
//
//
//  Created by Vinsi.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var environment: AppEnvironment
    @EnvironmentObject private var themeManager: ThemeManager
    @StateObject var viewModel: SearchViewModel
    @State var hasError = false

    init(useCase: MovieSearchUseCaseType) {
        _viewModel = StateObject(wrappedValue: SearchViewModel(useCase: useCase))
        hasError = hasError
    }

    var body: some View {
        VStack {
            ZStack {
                AppBackground()

                VStack(alignment: .leading, spacing: themeManager.currentTheme.spacing.small) {

                    SearchBarView(
                        changedText: $viewModel.searchText,
                        isLoading: $viewModel.isLoading,
                        placeholder: Localized.searchPlaceholder,
                        theme: themeManager.currentTheme
                    )

                    if case .success(let movies) = viewModel.dataState {
                        ItemListView(
                            movies: movies,
                            onTap: viewModel.onSelect(_:),
                            onAppear5thLastElement: nil
                        )
                    }

                    Spacer()
                }
                .padding(.top, themeManager.currentTheme.spacing.medium)
            }
        }

        .onChange(of: viewModel.dataState, perform: { newValue in
            if case .failure(let error) = newValue, let appError = error as? AppError {

                hasError = appError != .emptyValue
            } else {
                hasError = false
            }
        })
        .task {
            viewModel.setNavigationEventCallBack { [weak router] event in
                switch event {
                case .detail(let movieID):
                    router?.navigate(to: .details(id: movieID))
                }
            }
        }

        .errorAlert(
            isPresented: $hasError,
            errorMessage: viewModel.dataState.errorMessage,
            retryAction: viewModel.retry
        )
        .tabItem {
            Label(
                Localized.searchTitle,
                systemImage: themeManager.currentTheme.images.searchSystemIcon
            )
        }
    }
}

// MARK: - 🛠 Preview

import TMDBCore

#Preview {
    SearchView(useCase: MovieSearchUseCaseImpl(service:
        MockSearchServiceImpl()
    ))
    .environmentObject(AppEnvironment.shared)
    .environmentObject(Router())
    .environmentObject(ThemeManager())
}
