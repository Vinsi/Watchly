//
//  MovieGenreEndpoint.swift
//  Watchly
//
//  Created by Vinsi on 29/05/2025.
//

struct MovieGenreEndpoint: EndPointType {
    let request = RequestBuilder()

    typealias Response = GenreListResponse
//     --url https://api.themoviedb.org/3/genre/movie/list
    init(baseURL: String, token: String) {
        request.add(baseURL: baseURL)
            .add(token: token)
            .set(path: "3/genre/movie/list")
    }
}
