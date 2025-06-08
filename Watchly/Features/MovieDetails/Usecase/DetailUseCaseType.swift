//
//  DetailUseCaseType.swift
//
//
//  Created by Vinsi on 16/05/2025.
//

import Foundation
import SwiftUICore
import TMDBCore

protocol DetailUseCaseType {
    func getDetails(id: Int) async throws -> [DetailSection]
}

struct DetailUseCaseImpl: DetailUseCaseType {
    let service: MovieDetailsServiceType
    func getDetails(id: Int) async throws -> [DetailSection] {
        let details = try await service.getDetails(movieID: id)
        var sections: [DetailSection] = []
        let posterAttributes = PosterAttributes(
            poster: details.posterPath,
            movieTitle: details.title,
            tagLine: details.tagline,
            voteAverage: details.voteAverage,
            voteCount: details.voteCount,
            popularity: details.popularity
        )
        sections.append(.posterBackDrop(details.id, details.backdropPath))
        sections.append(.posterImage(posterAttributes))
        sections.append(.overview(details.overview))
        sections.append(.genres(details.genres))
        sections.append(.details(createAttributes(details: details)))
        sections.append(.link(url: details.homepage?.asURL))
        return sections
    }

    private func createAttributes(details: MovieDetails) -> [(LocalizedStringKey, String)] {
        [
            (Localized.Attributes.releaseDate, details.releaseDate),
            (Localized.Attributes.runtime, details.runtime.asRuntimeFormat),
            (Localized.Attributes.budget, details.budget.asMoneyFormat),
            (Localized.Attributes.revenue, details.revenue.asMoneyFormat),
            (Localized.Attributes.language, details.originalLanguage),
            (Localized.Attributes.production, details.productionCompanies.map { $0.name }.joined(separator: ", ")),
        ]
        .compactMap { value -> (LocalizedStringKey, String)? in
            guard let text = value.1 else {
                return nil
            }
            return (title: value.0, value: text)
        }
    }
}

struct PosterAttributes {
    let poster: TMDBImage?
    let movieTitle: String
    let tagLine: String?
    let votes: String
    let popularity: String

    init(
        poster: TMDBImage?,
        movieTitle: String,
        tagLine: String?,
        voteAverage: Double,
        voteCount: Int,
        popularity: Double
    ) {
        self.poster = poster
        self.movieTitle = movieTitle
        self.tagLine = tagLine
        votes = voteAverage.asStarRating() + String(format: "%.1f (%d votes)", voteAverage, voteCount)
        self.popularity = "\(popularity)"
    }
}

private extension Int? {

    var asRuntimeFormat: String? {
        guard let duration = self, duration > 0 else {
            return nil
        }
        return "\(duration) mins"
    }

    var asMoneyFormat: String? {
        guard let money = self, money > 0 else {
            return nil
        }
        return "$\(money.formatted())"
    }
}
