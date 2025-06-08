//
//  SidePanelView.swift
//  Watchly
//
//  Created by Vinsi on 05/06/2025.
//

import SwiftUI

struct SettingsView: View {
    @State private var language: String = "en"
    @EnvironmentObject var environment: AppEnvironment
    @EnvironmentObject var themeManager: ThemeManager
    @EnvironmentObject var appearenceManager: AppearanceManager
    @EnvironmentObject var languageManager: LanguageManager
    @State var selectedMode: String = "system"

    var body: some View {

        Form {
            // MARK: - Appearance

            Section(header: Text(Localized.Settings.appearance)) {
                Picker(Localized.Settings.theme, selection: $selectedMode) {
                    ForEach(AppearanceManager.Mode.allCases, id: \.rawValue) { value in
                        Text(value.rawValue.capitalized).tag(value.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .tint(themeManager.currentTheme.colors.primary)
            }
            .onChange(of: selectedMode) { value in
                appearenceManager.change(color: .init(value: value))
            }
            .onChange(of: appearenceManager.selectedColorScheme) { _ in
                selectedMode = appearenceManager.selectedColorMode.rawValue
            }
            .onAppear {
                selectedMode = appearenceManager.selectedColorMode.rawValue
            }

            // MARK: - Language

            Section(header: Text(Localized.Settings.applanguage)) {
                Picker(Localized.Settings.applanguage, selection: $language) {
                    ForEach(LanguageManager.SupportedLanguages.allCases, id: \.rawValue) { value in
                        Text(value.title).tag(value.rawValue)
                    }
                }
                .foregroundColor(themeManager.currentTheme.colors.primary)
                .pickerStyle(.menu)
            }

            // MARK: - About

            Section(header: Text(Localized.Settings.aboutme)) {
                HStack {
                    Text(Localized.Settings.version)
                        .foregroundColor(themeManager.currentTheme.colors.primary)

                    Spacer()
                    Text(environment.appVersion)
                        .foregroundColor(themeManager.currentTheme.colors.textSecondary)
                        .background(Color.clear)
                }

                HStack {
                    Text(Localized.Settings.environment)
                        .foregroundColor(themeManager.currentTheme.colors.primary)
                    Spacer()
                    Text(environment.scheme.rawValue.capitalized)
                        .foregroundColor(themeManager.currentTheme.colors.textSecondary)
                }
            }
            .onChange(of: language) { newValue in
                languageManager.setLanguage(LanguageManager.SupportedLanguages(rawValue: newValue) ?? .english)
            }
            .task {
                language = languageManager.selectedLanguage.rawValue
            }

            .listRowSeparator(.hidden)
            .listRowBackground(themeManager.currentTheme.colors.secondary)
            .listRowInsets(EdgeInsets(top: 30, leading: 8, bottom: 8, trailing: 8))
            .navigationTitle(Localized.Settings.settingTitle)
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(.clear))
            .edgesIgnoringSafeArea(.all)

            AboutMeView()
        }
    }
}
