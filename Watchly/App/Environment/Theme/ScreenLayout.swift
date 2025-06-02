//
//  ScreenLayout.swift
//  Watchly
//
//  Created by Vinsi on 02/06/2025.
//

import UIKit

enum ScreenLayout {
    static var screenWidth: CGFloat {
        UIScreen.main.bounds.width
    }

    static var screenHeight: CGFloat {
        UIScreen.main.bounds.height
    }

    static func height(_ percentage: CGFloat) -> CGFloat {
        return screenHeight * percentage
    }

    static func width(_ percentage: CGFloat) -> CGFloat {
        return screenWidth * percentage
    }

    static var aspectRatio: CGFloat {
        return screenWidth / screenHeight
    }

    static func gridLength(count: Int, spacing: CGFloat) -> CGFloat {
        (UIScreen.main.bounds.width - (CGFloat(count) + 1) * spacing) / CGFloat(count)
    }
}
