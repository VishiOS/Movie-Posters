//
//  MPNetworkConstants.swift
//  MoviePosters
//
//  Created by Vishal22 Sharma on 13/03/21.
//

import Foundation

typealias RequestHeaders = [String: String]
typealias DataTaskResult = (Data?, URLResponse?, Error?) -> ()

enum eApiName: String {
    case nowPlayingServicePath = "/movie/now_playing"
    case moviePopular = "/movie/popular"
    case topRatedMovie = "/movie/top_rated"
}

struct MPNetworkConstants {
   static var apiName: eApiName = .nowPlayingServicePath
    
    static let defaultRequestParams = ["api_key": "765e8f75e0e8142790000ebb46f22140"]
    static let defaultRequestHeaders = ["Content-type": "application/json; charset=utf-8"]
    static let baseURL = "https://api.themoviedb.org/3"
    static let nowPlayingServicePath = "/movie/now_playing"
    static let imagesBaseURL = "https://image.tmdb.org/t/p/w500/"
    static let queryParameterKey = "query"
    static let pageParameterKey = "page"
    static let releaseDatesServicePath = "/movie/movie_id/release_dates"
    static let movieId = "movie_id"
}
