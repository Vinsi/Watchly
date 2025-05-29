//
//  TrendingMoviesEndPoint.swift
//  Watchly
//
//  Created by Vinsi on 28/05/2025.
//


struct TrendingMoviesEndPoint: EndPointType {
    typealias Response = TrendingMoviesResponse
    let request = RequestBuilder()
    //'https://api.themoviedb.org/3/trending/movie/day?language=en-US'
    init(baseURL: String, token: String, page: Int = 0) {
        request
            .add(baseURL: baseURL)
            .add(token: token)
            .set(path: "3/trending/movie/day")
            .addQuery(query: .init(key: "language", value: "en-US"))
            .addQuery(query: .init(key: "page", value: "\(page)"))
    }
}