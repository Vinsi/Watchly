//
//  CustomBackButtonModifier.swift
//  Watchly
//
//  Created by Vinsi on 05/06/2025.
//

import SwiftUI

struct CustomBackButtonModifier: ViewModifier {
    @Environment(\.presentationMode) private var presentationMode
    let backIconName: String

    func body(content: Content) -> some View {
        content
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Image(backIconName)
                        }
                    }
                }
            }
    }
}

extension View {
    func withCustomBackButton(backIcon: String) -> some View {
        modifier(CustomBackButtonModifier(backIconName: backIcon))
    }
}
