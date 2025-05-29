//
//  Helper.swift
//  Watchly
//
//  Created by Vinsi on 28/05/2025.
//

import Foundation

enum TMDBImageSize: String {
    case w92, w154, w185, w342, w500, w780, original
}

struct TMDBImage: Codable, ExpressibleByStringLiteral {

    private let urlPath: String

    init(stringLiteral value: StringLiteralType) {
        urlPath = value
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        urlPath = try container.decode(String.self)
    }

    func getImageURL(size: TMDBImageSize, baseURLString: String = "https://image.tmdb.org/t/p/") -> URL? {
        URL(string: "\(baseURLString)\(size.rawValue)\(urlPath)")
    }
}

extension NetworkError {
    var toTMDBError: any Error {
        // swiftlint:disable opening_brace
        if case .unexpectedResponse(_, _, .some(let data)) = self,
           let model = try? JSONDecoder().decode(TMDBErrorResponse.self, from: data)
        {
            return IMDBServerError.serverError(model)
        }
        return self
        // swiftlint:enable opening_brace
    }
}

enum IMDBServerError: Error {
    case serverError(TMDBErrorResponse)
}
