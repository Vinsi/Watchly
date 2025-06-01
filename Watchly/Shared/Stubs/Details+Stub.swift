//
//  MockDetails.swift
//  Watchly
//
//  Created by Vinsi on 01/06/2025.
//
import TMDBCore

extension MovieDetails {

    static func stub(
        id: Int = 1,
        title: String = "Mock Movie",
        originalTitle: String = "Mock Original Title",
        overview: String = "This is a mocked movie used for previews and tests.",
        tagline: String? = "Mocked tagline",
        status: String = "Released",
        runtime: Int? = 120,
        releaseDate: String = "2025-06-01",
        voteAverage: Double = 7.3,
        voteCount: Int = 1340,
        popularity: Double = 88.8,
        adult: Bool = false,
        video: Bool = false,
        originalLanguage: String = "en",
        homepage: String? = "https://mockmovie.com",
        imdbID: String? = "tt1234567",
        posterPath: TMDBImage? = "/mockPoster.jpg",
        backdropPath: TMDBImage? = "/mockBackdrop.jpg",
        budget: Int? = 100_000_000,
        revenue: Int? = 250_000_000,
        genres: [Genre] = [.init(id: 1, name: "Action"), .init(id: 2, name: "Comedy")],
        spokenLanguages: [SpokenLanguage] = [],
        productionCompanies: [ProductionCompany] = [.stub()],
        productionCountries: [ProductionCountry] = [],
        originCountry: [String]? = ["US"],
        belongsToCollection: BelongsToCollection? = .stub()
    ) -> MovieDetails {
        MovieDetails(
            id: id,
            title: title,
            originalTitle: originalTitle,
            overview: overview,
            tagline: tagline,
            status: status,
            runtime: runtime,
            releaseDate: releaseDate,
            voteAverage: voteAverage,
            voteCount: voteCount,
            popularity: popularity,
            adult: adult,
            video: video,
            originalLanguage: originalLanguage,
            homepage: homepage,
            imdbID: imdbID,
            posterPath: posterPath,
            backdropPath: backdropPath,
            budget: budget,
            revenue: revenue,
            genres: genres,
            spokenLanguages: spokenLanguages,
            productionCompanies: productionCompanies,
            productionCountries: productionCountries,
            originCountry: originCountry,
            belongsToCollection: belongsToCollection
        )
    }
}

extension ProductionCompany {

    static func stub(
        id: Int = 1,
        name: String = "Mock Studios",
        logoPath: String? = nil,
        originCountry: String = "US"
    ) -> ProductionCompany {
        ProductionCompany(id: id, name: name, logoPath: logoPath, originCountry: originCountry)
    }
}

public extension BelongsToCollection {
    static func stub(
        id: Int = 1,
        name: String = "Mock Collection",
        posterPath: TMDBImage? = nil,
        backdropPath: TMDBImage? = nil
    ) -> BelongsToCollection {
        return BelongsToCollection(
            id: id,
            name: name,
            posterPath: posterPath,
            backdropPath: backdropPath
        )
    }
}
