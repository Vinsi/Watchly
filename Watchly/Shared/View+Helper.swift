//
//  View+Helper.swift
//
//
//  Created by Vinsi.
//
import SwiftUI

extension View {
    @ViewBuilder
    func square(size: CGFloat) -> some View {
        frame(width: size, height: size)
    }
}

struct AppBackground: View {
    @EnvironmentObject var themeManager: ThemeManager
    var body: some View {
        Image(themeManager.currentTheme.images.pattern)
            .resizable(resizingMode: .tile)
            .opacity(0.1)
    }
}

extension View {

    func errorAlert(
        isPresented: Binding<Bool>,
        errorMessage: String?,
        retryAction: @escaping () -> Void
    ) -> some View {
        alert(
            Localized.ErrorAlert.title,
            isPresented: isPresented,
            presenting: errorMessage
        ) { _ in
            Button(Localized.ErrorAlert.retry, action: retryAction)
        } message: { error in
            Text(error)
        }
    }
}
