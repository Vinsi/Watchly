//
//  AboutMeView.swift
//  Watchly
//
//  Created by Vinsi on 05/06/2025.
//

import SwiftUI

struct AboutMeView: View {
    @EnvironmentObject var themeManager: ThemeManager
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                // Avatar or placeholder icon
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 100, height: 100)
                    .foregroundColor(themeManager.currentTheme.colors.primary)
                    .padding(.top, 40)

                // Fun bio
                Text("""
                Hey there! I’m **Vinsimon** — a curious human and a long-time iOS developer 
                who spends way too much time chasing pixel-perfect UI and obsessing over crash-free code.

                I've been building iOS apps since the days when `Objective-C` was cool 
                and `storyboards` ruled the world.
                Now I mostly live in `Swift`, dabble in `SwiftUI`, and occasionally whisper sweet things to `Combine`.

                I’ve helped ship apps for streaming platforms, grocery delivery, logistics, 
                and even a live shopping experience (yes, your next snack deal might be powered by my code).

                When I'm not coding, I'm probably debugging why my daughter’s toys make more noise than Xcode.

                Have a feature idea? A bug to squish? Or just want to say hi?  
                **leo.winc@gmail.com**
                """)
                .font(themeManager.currentTheme.typography.body)
                .foregroundColor(themeManager.currentTheme.colors.textSecondary.opacity(0.6))
                .multilineTextAlignment(.leading)
                .padding(.horizontal)

                Spacer()
            }
            .padding(.bottom, 40)
        }
        .navigationTitle("About me")
        .navigationBarTitleDisplayMode(.inline)
    }
}
