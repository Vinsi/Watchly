//
//  Data+SHA.swift
//  Watchly
//
//  Created by Vinsi on 01/06/2025.
//

import CryptoKit
import Foundation

extension Data {
    func sha256() -> String {
        let hash = SHA256.hash(data: self)
        return hash.map { String(format: "%02x", $0) }.joined()
    }
}
