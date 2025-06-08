//
//  LanguageManager.swift
//  Watchly
//
//  Created by Vinsi on 08/06/2025.
//
import Foundation
import SwiftUICore
import TMDBCore

final class LanguageManager: ObservableObject {

    static let shared = LanguageManager()

    var keyValueStore: KeyValueStorage?

    enum SupportedLanguages: String, CaseIterable {
        case english = "en"
        case french = "fr"

        var title: LocalizedStringKey {
            switch self {
            case .english: Localized.Languages.english
            case .french: Localized.Languages.french
            }
        }
    }

    private init() {}

    @Published var selectedLanguage = SupportedLanguages.english

    func setLanguage(_ lang: SupportedLanguages) {
        keyValueStore?.set(lang.rawValue, forKey: "selectedLanguage")
        selectedLanguage = lang
    }

    func initialize(store: KeyValueStorage = UserDefaultsStorage()) {
        keyValueStore = store
        if let langCode: String = store.get(forKey: "selectedLanguage") {
            let lang = SupportedLanguages(rawValue: langCode) ?? .english
            selectedLanguage = lang
        }
    }
}

extension LanguageManager.SupportedLanguages {
    var tmdbLang: TMDBCore.TMDBLanguage {
        switch self {
        case .english: .english
        case .french: .french
        }
    }

    var locale: Locale {
        Locale(identifier: rawValue)
    }
}
