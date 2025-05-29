//
//  AppError.swift
//  Watchly
//
//  Created by Vinsi on 29/05/2025.
//
import Foundation

enum AppError: LocalizedError, Equatable {
    case network(description: String)
    case decoding(description: String)
    case unauthorized
    case server(message: String, code: Int)
    case custom(title: String, message: String)
    case emptyValue
    case unknown

    var errorDescription: String? {
        switch self {
        case .network(let desc): return "Network Error: \(desc)"
        case .decoding(let desc): return "Decoding Error: \(desc)"
        case .unauthorized: return "You are not authorized. Please login again."
        case .server(let message, let code): return "Server Error\(code): \(message)"
        case .custom(_, let message): return message
        case .emptyValue: return "Data Error"
        case .unknown: return "Something went wrong. Please try again."
        }
    }

    var title: String {
        switch self {
        case .custom(let title, _): return title
        default: return "Oops!"
        }
    }

    static func from(_ error: Error) -> AppError {
        if let urlError = error as? URLError {
            return .network(description: urlError.localizedDescription)
        } else if let decodingError = error as? DecodingError {
            return .decoding(description: decodingError.localizedDescription)
        } else if let serverError = error as? IMDBServerError {
            return .server(message: serverError.model.statusMessage, code: serverError.model.statusCode)
        } else if (error as NSError).code == 401 {
            return .unauthorized
        } else {
            return .unknown
        }
    }
}
