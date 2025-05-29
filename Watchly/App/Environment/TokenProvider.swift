//
//  TokenProvider.swift
//
//
//  Created by Vinsi.
//

/// 🔐 **Token Provider**
/// Provides authentication token for API requests.
protocol TokenProvider {
    var token: String { get }
}
