//
//  Router.swift
//
//
//  Created by Vinsi.
//

import SwiftUI

final class Router: ObservableObject {

    public enum Destination: Codable, Hashable {
        case details(id: Int)
    }

    // Define top-level tabs
    public enum Tab: String, Equatable, CaseIterable {
        case list
        case search

        var title: LocalizedStringKey {
            switch self {
            case .list: Localized.homeTitle
            case .search: Localized.searchTitle
            }
        }
    }

    @Published var navPath = NavigationPath()
    @Published var selectedTab: Tab = .list

    func navigate(to destination: Destination) {
        navPath.append(destination)
    }

    func navigateBack() {
        navPath.removeLast()
    }

    func navigateToRoot() {
        navPath.removeLast(navPath.count)
    }
}

extension Router.Destination {

    @MainActor @ViewBuilder
    var toView: some View {
        switch self {
        case .details(let movieID):
            DetailCoordinator(environment: AppEnvironment.shared,
                              languageManager: LanguageManager.shared,
                              movieID: movieID).start()
        }
    }
}

extension View {
    func navigateUsingRouter() -> some View {
        navigationDestination(for: Router.Destination.self) { destination in
            destination.toView
        }
    }
}
