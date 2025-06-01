//
//  String+Star.swift
//  Watchly
//
//  Created by Vinsi on 01/06/2025.
//

extension Double {
    func asStarRating(maxStars: Int = 10) -> String {

        let fullStars = Int(self)
        let fractional = self - Double(fullStars)

        let halfStar = fractional >= 0.75 ? 1 : (fractional >= 0.25 ? 0.5 : 0.0)
        let filledStars = fullStars + (halfStar == 1 ? 1 : 0)
        let halfStars = halfStar == 0.5 ? 1 : 0
        let emptyStars = maxStars - filledStars - halfStars

        return String(repeating: "★", count: filledStars)
            + String(repeating: "☆", count: halfStars) // substitute for half star
            + String(repeating: "☆", count: emptyStars)
    }
}
