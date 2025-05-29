//
//  MovieDetailEndPoint.swift
//  Watchly
//
//  Created by Vinsi on 28/05/2025.
//


struct MovieDetailEndPoint: EndPointType {
    let request = RequestBuilder()

    typealias Response = MovieDetails
//     --url 'https://api.themoviedb.org/3/search/movie?query=mat&include_adult=false&language=en-US&page=1'
    init(baseURL: String, token: String, page: Int = 0) {
        request.add(baseURL: baseURL)
            .add(token: token)
            .set(path: "3/search/movie")
            .addQuery(query: .init(key: "query", value: ""))
            .addQuery(query: .init(key: "include_adult", value: "false"))
            .addQuery(query: .init(key: "language", value: "en-US"))
            .addQuery(query: .init(key: "page", value: "\(page)"))
    }

}

