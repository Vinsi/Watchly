//
//  MovieDetails.swift
//  Watchly
//
//  Created by Vinsi on 28/05/2025.
//



// MARK: - MovieDetails
struct MovieDetails: Codable {
    let id: Int
    let title: String
    let originalTitle: String
    let overview: String
    let tagline: String?
    let status: String
    let runtime: Int?
    let releaseDate: String
    let voteAverage: Double
    let voteCount: Int
    let popularity: Double
    let adult: Bool
    let video: Bool
    let originalLanguage: String
    let homepage: String?
    let imdbID: String?
    let posterPath: TMDBImage?
    let backdropPath: TMDBImage?
    let budget: Int?
    let revenue: Int?
    let genres: [Genre]
    let spokenLanguages: [SpokenLanguage]
    let productionCompanies: [ProductionCompany]
    let productionCountries: [ProductionCountry]
    let originCountry: [String]?
    let belongsToCollection: BelongsToCollection?

    enum CodingKeys: String, CodingKey {
        case id, title, overview, tagline, status, runtime, adult, video, popularity, budget, revenue
        case originalTitle = "original_title"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case originalLanguage = "original_language"
        case homepage, imdbID = "imdb_id"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case genres
        case spokenLanguages = "spoken_languages"
        case productionCompanies = "production_companies"
        case productionCountries = "production_countries"
        case originCountry = "origin_country"
        case belongsToCollection = "belongs_to_collection"
    }
}

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}

// MARK: - SpokenLanguage
struct SpokenLanguage: Codable {
    let englishName: String
    let iso6391: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso6391 = "iso_639_1"
        case name
    }
}

// MARK: - ProductionCompany
struct ProductionCompany: Codable {
    let id: Int
    let name: String
    let logoPath: String?
    let originCountry: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case logoPath = "logo_path"
        case originCountry = "origin_country"
    }
}

// MARK: - ProductionCountry
struct ProductionCountry: Codable {
    let iso3166_1: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case iso3166_1 = "iso_3166_1"
        case name
    }
}

// MARK: - BelongsToCollection
struct BelongsToCollection: Codable {
    let id: Int
    let name: String
    let posterPath: TMDBImage?
    let backdropPath: TMDBImage?

    enum CodingKeys: String, CodingKey {
        case id, name
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
}


