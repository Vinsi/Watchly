//
//  KeyValueStorage.swift
//  Watchly
//
//  Created by Vinsi on 30/05/2025.
//

protocol KeyValueStorage {
    func set<T: Codable>(_ value: T, forKey key: String)
    func get<T: Codable>(forKey key: String) -> T?
    func remove(forKey key: String)
    func contains(_ key: String) -> Bool
}
