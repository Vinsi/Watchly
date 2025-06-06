//
//  SidePanelView.swift
//  Watchly
//
//  Created by Vinsi on 05/06/2025.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("colorscheme") private var appearance: String = "system"
    @AppStorage("language") private var language: String = "en"
    @EnvironmentObject var environment: AppEnvironment
    @EnvironmentObject var themeManager: ThemeManager

    var body: some View {

        Form {
            // MARK: - Appearance

            Section(header: Text("Appearance")) {
                Picker("Theme", selection: $appearance) {
                    Text("System").tag("system")
                    Text("Light").tag("light")
                    Text("Dark").tag("dark")
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            .onChange(of: appearance) { value in
                themeManager.changeColorScheme(mode: value)
            }

            // MARK: - Language

            Section(header: Text("Language")) {
                Picker("App Language", selection: $language) {
                    Text("English").tag("en")
                    Text("French").tag("fr")
                }
                .foregroundColor(themeManager.currentTheme.colors.primary)
                .pickerStyle(.menu)
            }

            // MARK: - About

            Section(header: Text("About")) {
                HStack {
                    Text("Version")
                        .foregroundColor(themeManager.currentTheme.colors.primary)

                    Spacer()
                    Text(environment.appVersion)
                        .foregroundColor(themeManager.currentTheme.colors.textSecondary)
                        .background(Color.clear)
                }

                HStack {
                    Text("Environment")
                        .foregroundColor(themeManager.currentTheme.colors.primary)
                    Spacer()
                    Text(environment.scheme.rawValue.capitalized)
                        .foregroundColor(themeManager.currentTheme.colors.textSecondary)
                }
                AboutMeView()
            }

            .listRowBackground(themeManager.currentTheme.colors.secondary)
            .listRowInsets(EdgeInsets(top: 30, leading: 20, bottom: 8, trailing: 20))
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(.clear))
            .edgesIgnoringSafeArea(.all)
        }
    }

}
