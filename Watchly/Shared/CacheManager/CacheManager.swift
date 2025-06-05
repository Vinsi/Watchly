//
//  CacheManager.swift
//
//
//  Created by Vinsi.
//
import Foundation
import TMDBCore
import UIKit

final class CacheManager {
    static let shared = CacheManager()
    private init() {}
    private(set) lazy var imageCache: GeneralCache<String, UIImage> = GeneralCache(maxSize: 100)
    private(set) lazy var trendingMoviesResponseCache: GeneralCache<String, TrendingMoviesResponse> = .init(maxSize: 1)
    private(set) lazy var movieDetailsResponseCache: GeneralCache<String, MovieDetails> = .init(maxSize: 50)
    private(set) lazy var searchResponseCache: GeneralCache<String, SearchResultsResponse> = .init(maxSize: 50)
}
