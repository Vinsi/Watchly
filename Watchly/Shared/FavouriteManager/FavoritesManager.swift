//
//  FavoritesManager.swift
//  Watchly
//
//  Created by Vinsi on 30/05/2025.
//
import Foundation

final class FavouritesManager: ObservableObject {
    private let storage: KeyValueStorage
    private let key = "favourite_movie_ids"
    @Published var ids: [Int]

    init(storage: KeyValueStorage) {
        self.storage = storage
        ids = storage.get(forKey: key) ?? []
    }

    func getFavourites() -> [Int] {
        storage.get(forKey: key) ?? []
    }

    func add(_ id: Int) {
        var ids = getFavourites()
        if !ids.contains(id) {
            ids.append(id)
            storage.set(ids, forKey: key)
            self.ids = ids
        }
    }

    func remove(_ id: Int) {
        var ids = getFavourites()
        ids.removeAll { $0 == id }
        storage.set(ids, forKey: key)
        self.ids = ids
    }

    func toggle(_ id: Int) {
        if isFavourite(id) {
            remove(id)
        } else {
            add(id)
        }
    }

    func isFavourite(_ id: Int) -> Bool {
        getFavourites().contains(id)
    }
}
