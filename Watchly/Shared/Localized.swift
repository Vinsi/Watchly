//
//  Localized.swift
//
//
//  Created by Vinsi.
//

import Foundation

enum Localized {
    // General Titles
    static let detailTitle = String(localized: "detail_title")
    static let homeTitle = String(localized: "home_title")
    static let searchTitle = String(localized: "search_title")
    static let settingTitle = String(localized: "setting_title")
    static let searchPlaceholder = String(localized: "search_placeholder")
    static let searchButton = String(localized: "search_button")

    enum ErrorAlert {
        static let title = String(localized: "error")
        static let retry = String(localized: "retry")
    }

    // Error Messages
    enum Error {
        static let malformedURL = String(localized: "malformed_url")
        static let unknown = String(localized: "unknown")
        static let disconnected = String(localized: "disconnected")
        static let noInternetConnection = String(localized: "no_internet_connection")
        static let connectionError = String(localized: "connection_error")
        static func failedToDecode(message: String) -> String {
            String(format: NSLocalizedString("failed_to_decode", comment: ""), message)
        }
    }
}
