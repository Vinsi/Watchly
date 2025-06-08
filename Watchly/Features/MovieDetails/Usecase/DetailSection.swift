//
//  DetailSection.swift
//
//
//  Created by Vinsi.
//

import Foundation
import SwiftUI
import TMDBCore

enum DetailSection: Identifiable {

    case posterBackDrop(Int, TMDBImage?)
    case posterImage(PosterAttributes)
    case overview(String)
    case genres([Genre])
    case details([(title: LocalizedStringKey, value: String)])
    case link(url: URL?)

    var id: String {
        switch self {
        case .posterBackDrop:
            return "backdrop"
        case .posterImage:
            return "posterimage"
        case .overview:
            return "overview"
        case .genres:
            return "genres"
        case .details:
            return "details"
        case .link:
            return "link"
        }
    }

    var title: LocalizedStringKey {
        switch self {
        case .posterBackDrop:
            return ""
        case .posterImage:
            return ""
        case .overview:
            return Localized.Sections.overview
        case .genres:
            return Localized.Sections.genres
        case .details:
            return Localized.Sections.details
        case .link:
            return Localized.Attributes.gotowebsite
        }
    }

    func horizontalPadding(padding: CGFloat) -> CGFloat {
        if case .posterBackDrop = self {
            return 0
        } else {
            return padding
        }
    }
}
