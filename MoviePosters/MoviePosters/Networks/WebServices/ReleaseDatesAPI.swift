//
//  ReleaseDatesAPPI.swift
//  MoviePosters
//
//  Created by Vishal22 Sharma on 14/03/21.
//

import Foundation
class ReleaseDatesAPI: Service {

    var paramters: [String: String]?

    init(paramters: [String: String]?) {
        self.paramters = paramters
        self.paramters?.append(dict: MPNetworkConstants.defaultRequestParams)
    }

    var baseURL: URL {
        return URL(string: MPNetworkConstants.baseURL)!
    }

    var path: String {
        let serviceRequest = MPNetworkConstants.releaseDatesServicePath
        
        let servicePath = serviceRequest.replacingOccurrences(of: "movie_id", with: paramters?["movie_id"] ?? "", options: .literal, range: nil)

        return servicePath
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

protocol ReleaseDatesAPIServices {
    func getMoviewReleaseDate(service: Service, completion: @escaping (_ result: APIResponse<ReleaseDateResponse>) -> ())
}
