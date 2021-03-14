//
//  NowPlayingResponse.swift
//  MoviePosters
//
//  Created by Vishal22 Sharma on 13/03/21.
//

import Foundation
struct NowPlayingResponse: Codable {
    var movies: [Movie]
    var totalPages: Int

    enum CodingKeys: String, CodingKey {
        case movies = "results"
        case totalPages = "total_pages"
    }
}

struct ReleaseDateResponse: Codable {
    var id: Int
    var results: [Results]
}

struct Results: Codable {
    var releaseDates: [ReleaseDate]
    
    enum CodingKeys: String, CodingKey {
        case releaseDates = "release_dates"
    }
    
}
struct ReleaseDate: Codable {
    var releaseDate: String
    
    enum CodingKeys: String, CodingKey {
        case releaseDate = "release_date"
    }
}
