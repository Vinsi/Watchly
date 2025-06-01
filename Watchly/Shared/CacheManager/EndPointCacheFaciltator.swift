//
//  EndPointCacheFaciltator.swift
//  Watchly
//
//  Created by Vinsi on 01/06/2025.
//
import TMDBCore

final class EndPointCacheFaciltator<T: EndPointType> {
    let cache: GeneralCache<String, T.Response>

    init(cache: GeneralCache<String, T.Response> = .init(maxSize: 100)) {
        self.cache = cache
    }

    func executeWithCache(endPoint: T, network: NetworkProcesserType) async throws -> T.Response {
        if let object = await cache.getValue(forKey: endPoint.cacheKey) {
            logNet.logI("response.from.cache")
            return object
        } else {
            logNet.logI("response.from.network")
            let object = try await network.request(from: endPoint)
            await cache.setValue(object, forKey: endPoint.cacheKey)
            return object
        }
    }

    func executeDirectlyAndSaveCache(endPoint: T, network: NetworkProcesserType) async throws -> T.Response {
        let object = try await network.request(from: endPoint)
        await cache.setValue(object, forKey: endPoint.cacheKey)
        return object
    }
}

extension EndPointType {
    var cacheKey: String {
        var components = [String]()
        guard let request = try? self.request.makeUrlRequest() else {
            return ""
        }

        // URL base
        components.append(request.url?.absoluteString ?? "")

        // HTTP Method
        components.append(request.httpMethod ?? "GET")

        // Headers (sorted for consistency)
        if let headers = request.allHTTPHeaderFields {
            let sortedHeaders = headers.sorted { $0.key < $1.key }
            components.append(sortedHeaders.map { "\($0.key)=\($0.value)" }.joined(separator: "&"))
        }

        // HTTP Body (optional, hashed for safety)
        if let body = request.httpBody {
            let bodyHash = body.sha256() // you can define this below
            components.append(bodyHash)
        }

        return components.joined(separator: "|")
    }
}
