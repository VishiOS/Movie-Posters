//
//  MPMovieDetailViewModel.swift
//  MoviePosters
//
//  Created by Vishal22 Sharma on 14/03/21.
//

import UIKit

class MPMovieDetailViewModel: NSObject {
    private let webServices: WebServices
    
    init(webServices: WebServices = WebServices()) {
        self.webServices = webServices
    }
    
//    func getMovieReleaseDate(completion: @escaping ((_ status: Bool, _ error: Error?) -> ())) {
//        
//        webServices.getNowPlayingMovies(service: NowPlayingAPI(paramters: [MPNetworkConstants.pageParameterKey: "\(currentPage)"]), completion: { [weak self] response in
//            self?.state.value = .finishedLoading
//            switch response {
//            case .success(let result):
//                self?.nowPlayingList.value.append(contentsOf: result.movies)
//                self?.totalPages = result.totalPages
//                self?.currentPage += 1
//                completion(true, nil)
//            case .failure(let error):
//                self?.state.value = .error(error)
//            }
//        })
//    }
}
