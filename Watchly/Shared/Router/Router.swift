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
    public enum Tab: String, CaseIterable {
        case list
        case search

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
        case .details(let movies):
            EmptyView()
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
