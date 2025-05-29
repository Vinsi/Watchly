//
//  TMDBErrorResponse.swift
//  Watchly
//
//  Created by Vinsi on 28/05/2025.
//

struct TMDBErrorResponse: Codable {
    let success: Bool
    let statusCode: Int
    let statusMessage: String

    enum CodingKeys: String, CodingKey {
        case success
        case statusCode = "status_code"
        case statusMessage = "status_message"
    }
}
