//
//  NetworkEnums.swift
//  MoviePosters
//
//  Created by Vishal22 Sharma on 13/03/21.
//

import Foundation
enum HTTPMethod: String {
    case get    = "GET"
    case post   = "POST"
    case put    = "PUT"
    case delete = "DELETE"
}

enum Task {
    case requestPlain
    case requestParameters([String: String])
}

enum ParametersEncoding {
    case url
    case json
}

enum APIResponse<T> {
    case success(T)
    case failure(NetworkError)
}

enum NetworkError {
    case unauthorized
    case unknown
    case noJSONData
    case JSONDecoder
}

enum FetchingServiceState: Equatable {
    case loading
    case finishedLoading
    case error(NetworkError?)
}
