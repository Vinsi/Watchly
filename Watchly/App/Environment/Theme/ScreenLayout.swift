//
//  ScreenLayout.swift
//  Watchly
//
//  Created by Vinsi on 02/06/2025.
//

import SwiftUI
import UIKit

struct Layout {

    let width: CGFloat
    let height: CGFloat

    static let deviceScreen = Layout(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
    static let safeScreen = {
        let window = UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first { $0.isKeyWindow }

        if let insets = window?.safeAreaInsets {
            return Layout(size: UIScreen.main.bounds.inset(by: insets).size)
        }
        return Layout(size: UIScreen.main.bounds.size)

    }()

    func height(_ percentage: CGFloat) -> CGFloat {
        return height * percentage
    }

    func width(_ percentage: CGFloat) -> CGFloat {
        return width * percentage
    }

    var aspectRatio: CGFloat {
        return width / height
    }

    func gridLength(count: Int, spacing: CGFloat) -> CGFloat {
        (width - (CGFloat(count) + 1) * spacing) / CGFloat(count)
    }

    static func expectedColumnWidths(
        gridItems: [GridItem],
        horizontalPadding: CGFloat = 0,
        containerWidth: CGFloat
    ) -> [CGFloat?] {
        let totalSpacing = gridItems.dropLast().reduce(0) { $0 + ($1.spacing ?? 8) }
        let availableWidth = containerWidth - (2 * horizontalPadding) - totalSpacing

        let totalFixedWidth = gridItems.reduce(0) { result, item in
            if case .fixed(let width) = item.size {
                return result + width
            } else {
                return result
            }
        }

        let flexibleItems = gridItems.filter {
            if case .flexible = $0.size { return true }
            return false
        }

        let flexibleCount = flexibleItems.count
        let flexibleAvailableWidth = max(availableWidth - totalFixedWidth, 0)
        let flexibleColumnWidth = flexibleCount > 0 ? flexibleAvailableWidth / CGFloat(flexibleCount) : 0

        // Final mapping for all columns
        return gridItems.map { item in
            switch item.size {
            case .fixed(let width):
                return width
            case .flexible(let minValue, let maxValue):
                return min(max(minValue, flexibleColumnWidth), maxValue)
            default:
                return nil // adaptive not predictable per-column
            }
        }
    }
}

extension Layout {

    init(size: CGSize) {
        width = size.width
        height = size.height
    }
}
