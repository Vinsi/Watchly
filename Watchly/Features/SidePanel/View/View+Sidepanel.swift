//
//  View+Sidepanel.swift
//  Watchly
//
//  Created by Vinsi on 05/06/2025.
//

import SwiftUI

extension View {
    func withSidePanel<SidePanel: View>(
        isPresented: Binding<Bool>,
        @ViewBuilder sidePanel: @escaping () -> SidePanel
    ) -> some View {
        modifier(SidePanelModifier(sidePanel: sidePanel, isPresented: isPresented))
    }
}
