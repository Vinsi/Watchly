//
//  RequestBuilder+App.swift
//
//
//  Created by Vinsi.
//

extension RequestBuilder {

    @discardableResult
    func add(baseURL: String) -> Self {
        set(baseURL: baseURL)
        return self
    }

    @discardableResult
    func add(token: String) -> Self {
        addHeader(key: "Authorization", value: token.appendBearer)
        return self
    }
}

extension String {

    var appendBearer: String {
        "Bearer \(self)"
    }
}
