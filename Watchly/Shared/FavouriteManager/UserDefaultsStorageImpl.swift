//
//  UserDefaultsStorageImpl.swift
//  Watchly
//
//  Created by Vinsi on 30/05/2025.
//

import Foundation

final class UserDefaultsStorage: KeyValueStorage {
    private let defaults: UserDefaults
    private static let queue = DispatchQueue(label: "UserDefaultsStorage.queue", attributes: .concurrent)

    init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    func set<T: Codable>(_ value: T, forKey key: String) {
        UserDefaultsStorage.queue.async(flags: .barrier) {
            if let data = try? JSONEncoder().encode(value) {
                self.defaults.set(data, forKey: key)
            }
        }
    }

    func get<T: Codable>(forKey key: String) -> T? {
        var result: T?
        UserDefaultsStorage.queue.sync {
            guard let data = self.defaults.data(forKey: key) else { return }
            result = try? JSONDecoder().decode(T.self, from: data)
        }
        return result
    }

    func remove(forKey key: String) {
        UserDefaultsStorage.queue.async(flags: .barrier) {
            self.defaults.removeObject(forKey: key)
        }
    }

    func contains(_ key: String) -> Bool {
        var exists = false
        UserDefaultsStorage.queue.sync {
            exists = self.defaults.object(forKey: key) != nil
        }
        return exists
    }
}
