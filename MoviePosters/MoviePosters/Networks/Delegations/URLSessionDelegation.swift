//
//  URLSessionDelegation.swift
//  MoviePosters
//
//  Created by Vishal22 Sharma on 13/03/21.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask
}
