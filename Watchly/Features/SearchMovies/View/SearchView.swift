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
    @EnvironmentObject private var langManager: LanguageManager
    @StateObject var viewModel: SearchViewModel
    @State var hasError = false

    init(useCase: MovieSearchUseCaseType, onNavigationEvent: Closure<SearchViewModel.NavigationEvent>? = nil) {
        let viewModel = SearchViewModel(useCase: useCase)
        viewModel.navigationEventCallBack = onNavigationEvent
        _viewModel = StateObject(wrappedValue: viewModel)
        hasError = hasError
    }

    var body: some View {
        VStack {
            ZStack {
                AppBackground()

                VStack(alignment: .leading, spacing: themeManager.currentTheme.spacing.small) {

                    SearchBarView(
                        changedText: $viewModel.searchText,
                        isLoading: $viewModel.pageIsLoading,
                        placeholder: Localized.searchPlaceholder,
                        theme: themeManager.currentTheme
                    )
                    .padding(.horizontal, themeManager.currentTheme.spacing.small)

                    if case .success = viewModel.dataState {
                        ItemListView(
                            movies: viewModel.viewData,
                            onTap: viewModel.onSelect(_:),
                            onAppear5thLastElement: {
                                Task {
                                    try await viewModel.pagingManager.fetchNextPage()
                                }
                            }
                        )
                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.top, themeManager.currentTheme.spacing.small)
            }
        }

        .onChange(of: viewModel.dataState, perform: { newValue in
            if case .failure(let error) = newValue, let appError = error as? AppError {

                hasError = appError != .emptyValue
            } else {
                hasError = false
            }
        })
        .onChange(of: langManager.selectedLanguage) { _ in
            viewModel.searchText = ""
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
