//
//  Localized.swift
//
//
//  Created by Vinsi.
//

import Foundation
import SwiftUI

enum Localized {
    // General Titles
    static let detailTitle: LocalizedStringKey = "detail.title"
    static let homeTitle: LocalizedStringKey = "home.title"
    static let searchTitle: LocalizedStringKey = "search.title"

    static let searchPlaceholder: LocalizedStringKey = "search.placeholder"

    enum ErrorAlert {
        static let title: LocalizedStringKey = "error"
        static let retry: LocalizedStringKey = "retry"
    }

    // Error Messages
    enum Error {
        static let malformedURL: LocalizedStringKey = "error.malformed"
        static let unknown: LocalizedStringKey = "error.unknown"
        static let disconnected: LocalizedStringKey = "error.disconnected"
        static let noInternetConnection: LocalizedStringKey = "error.nointernet"
        static let connectionError: LocalizedStringKey = "error.connection"
        static let decodeError: LocalizedStringKey = "error.failedtodecode"
    }

    enum Attributes {
        static let releaseDate: LocalizedStringKey = "release.date"
        static let runtime: LocalizedStringKey = "runtime"
        static let budget: LocalizedStringKey = "budget"
        static let revenue: LocalizedStringKey = "revenue"
        static let language: LocalizedStringKey = "language"
        static let production: LocalizedStringKey = "production"
        static let gotowebsite: LocalizedStringKey = "goto.website"
    }

    enum Sections {
        static let details: LocalizedStringKey = "details"
        static let genres: LocalizedStringKey = "genres"
        static let overview: LocalizedStringKey = "overview"
    }

    enum Settings {
        // static let aboutmeContent: LocalizedStringKey = "about.me.content"
        static let applanguage: LocalizedStringKey = "app.language"
        static let version: LocalizedStringKey = "version.title"
        static let environment: LocalizedStringKey = "environment.title"
        static let appearance: LocalizedStringKey = "appearence"
        static let theme: LocalizedStringKey = "theme"
        static let settingTitle: LocalizedStringKey = "setting.title"
        static let aboutme: LocalizedStringKey = "setting.aboutme"

        static func aboutMe(appName: String) -> LocalizedStringKey {
            "about.me.content\(appName)"
        }
    }

    enum Languages {
        static let english: LocalizedStringKey = "language.english"
        static let french: LocalizedStringKey = "language.french"
    }
}
