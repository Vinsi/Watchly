//
//  DeviceOrientation.swift
//  Watchly
//
//  Created by Vinsi on 05/06/2025.
//

import SwiftUI
import UIKit

final class DeviceOrientationObserver: ObservableObject {
    static let shared = DeviceOrientationObserver()
    @Published var orientation: UIDeviceOrientation = UIDevice.current.orientation

    private init() {
        UIDevice.current.beginGeneratingDeviceOrientationNotifications()

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(orientationChanged),
            name: UIDevice.orientationDidChangeNotification,
            object: nil
        )
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
        UIDevice.current.endGeneratingDeviceOrientationNotifications()
    }

    @objc private func orientationChanged() {
        let newOrientation = UIDevice.current.orientation
        if newOrientation.isValidInterfaceOrientation {
            orientation = newOrientation
        }
    }

    var isLandscape: Bool {
        orientation.isLandscape
    }

    var isPortrait: Bool {
        orientation.isPortrait
    }
}
