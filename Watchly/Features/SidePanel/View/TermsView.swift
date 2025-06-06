//
//  TermsView.swift
//  Watchly
//
//  Created by Vinsi on 05/06/2025.
//
import SwiftUI

struct TermsView: View {
    @EnvironmentObject var environment: AppEnvironment
    @EnvironmentObject var themeManager: ThemeManager
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Terms and Conditions")
                    .font(.title)
                    .bold()
                    .padding(.top)

                Text("""
                Welcome to \(environment.appName), a personal application created and owned by Vinsimon Thulaseedharan.
                By accessing or using this app, you agree to the following terms.

                1. **Personal Use**
                This app is built and maintained as a personal project. 
                It is not a commercial product and is intended for testing and experimentation purposes only.

                2. **Ownership**
                All features, content, code, and intellectual property 
                within this app are the personal property of Vinsimon Thulaseedharan. Unauthorized reproduction, distribution,
                or modification is not permitted.

                3. **Data & Privacy**
                This app does not intentionally collect or share any personal data. 
                Any inputs or information entered are for local use only and are not stored or transmitted externally.

                4. **Disclaimer**
                This app is provided “as is” with no guarantees of stability, accuracy,
                or fitness for any particular purpose. Use at your own risk.

                5. **Contact**
                For any questions or concerns related to this app, you may reach out directly to:

                **Email:** leo.winc@gmail.com

                6. **Updates**
                These terms may change without prior notice, especially as features are updated or refined.

                Thank you for using \(environment.appName).
                """)
                .font(themeManager.currentTheme.typography.body)
                .foregroundColor(themeManager.currentTheme.colors.textSecondary.opacity(0.4))

                Spacer()
            }
            .padding()
        }
        .navigationTitle("Terms of Service")
        .navigationBarTitleDisplayMode(.inline)
    }
}
