//
//  ListViewDataType.swift
//
//
//  Created by Vinsi.
//
import Foundation

// MARK: - 🐱 ListViewDataType Protocol

/// A protocol that defines the data required for displaying a movie in a list.
/// This ensures that any model conforming to it provides essential movie information.

import TMDBCore

protocol ListViewDataType {
    var movieID: Int { get }
    var title: String { get }
    var posterImagePath: TMDBImage? { get }
    var shortDescription: String { get }
    var voteAverage: Double { get }
    var popularityScore: Double { get }
    var releaseDate: String? { get }
    var genres: [String] { get }
}

extension Movie: ListViewDataType {
    var posterImagePath: TMDBImage? {
        posterPath
    }

    var movieID: Int {
        id
    }

    var shortDescription: String {
        overview
    }

    var popularityScore: Double {
        popularity
    }

    var genres: [String] {
        genreIDs.map { "\($0)" }
    }
}
