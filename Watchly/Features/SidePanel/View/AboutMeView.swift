//
//  AboutMeView.swift
//  Watchly
//
//  Created by Vinsi on 05/06/2025.
//

import SwiftUI

struct AboutMeView: View {
    @EnvironmentObject var environment: AppEnvironment
    @EnvironmentObject var themeManager: ThemeManager
    var body: some View {

        ZStack {
            ProfileBackGround()
            VStack(spacing: 20) {
                // Avatar or placeholder icon
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(themeManager.currentTheme.colors.primary)
                    .padding(.top, 40)

                // Fun bio
                Text(Localized.Settings.aboutme)
                    .font(themeManager.currentTheme.typography.body)
                    .foregroundColor(themeManager.currentTheme.colors.textSecondary.opacity(0.6))
                    .multilineTextAlignment(.leading)

                // Fun bio
                Text(Localized.Settings.aboutMe(appName: environment.appName))
                    .font(themeManager.currentTheme.typography.body)
                    .foregroundColor(themeManager.currentTheme.colors.textSecondary.opacity(0.6))
                    .multilineTextAlignment(.leading)

                Spacer()
            }
        }
    }
}
