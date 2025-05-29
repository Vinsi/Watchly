//
//  GetGenresUseCaseType.swift
//  Watchly
//
//  Created by Vinsi on 29/05/2025.
//

protocol GetGenresUseCaseType {
    func fetch() async throws -> [Int: String]
}

struct GetGenresUseCaseImpl: GetGenresUseCaseType {
    let service: MovieGenreListServiceType
    func fetch() async throws -> [Int: String] {
        let genres = try await service.getAll().genres
        let genDictionary = genres.reduce([Int: String]()) {
            var prev = $0
            prev[$1.id] = $1.name
            return prev
        }
        return genDictionary
    }
}
