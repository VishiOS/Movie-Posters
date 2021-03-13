//
//  NowPlayingAPI.swift
//  MoviePosters
//
//  Created by Vishal22 Sharma on 13/03/21.
//

import Foundation

class NowPlayingAPI: Service {

    var paramters: [String: String]?

    init(paramters: [String: String]?) {
        self.paramters = paramters
        self.paramters?.append(dict: MPNetworkConstants.defaultRequestParams)
    }

    var baseURL: URL {
        return URL(string: MPNetworkConstants.baseURL)!
    }

    var path: String {
        return MPNetworkConstants.nowPlayingServicePath
    }

    var method: HTTPMethod {
        return .get
    }

    var task: Task {
        return .requestParameters(self.paramters ?? [:])
    }

    var headers: RequestHeaders? {
        return MPNetworkConstants.defaultRequestHeaders
    }

    var parametersEncoding: ParametersEncoding {
        return .url
    }
}

protocol NowPlayingAPIService {
    func getNowPlayingMovies(service: Service, completion: @escaping (_ result: APIResponse<NowPlayingResponse>) -> ())
}

