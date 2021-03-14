//
//  MPMovieDetailViewModel.swift
//  MoviePosters
//
//  Created by Vishal22 Sharma on 14/03/21.
//

import UIKit

class MPMovieDetailViewModel: NSObject {
    private let webServices: WebServices
    private (set) var state: Bindable<FetchingServiceState> = Bindable(.loading)
    
    init(webServices: WebServices = WebServices()) {
        self.webServices = webServices
    }
    
    
    func fetchReleaseDates(movie:Movie?, completion: @escaping ((_ status: String, _ error: Error?) -> ())) {
        state.value = .loading
        
        let movieId = movie?.id ?? 0
        
        
        
        webServices.getMoviewReleaseDate(service: ReleaseDatesAPI(paramters: [MPNetworkConstants.movieId: String(movieId)]), completion: { [weak self] response in
            self?.state.value = .finishedLoading
            switch response {
            case .success(let result):
                let response = result.results[0].releaseDates
                //response[0].releaseDate
                let date = self?.getDateFromString(dateString: response[0].releaseDate)
                
                completion(self?.getDateFromString(dateString: date) ?? "", nil)
            case .failure(let error):
                self?.state.value = .error(error)
            }
        })
    }
    
    func getDateFromString(dateString: String?) -> String {
        
        let date = "2016-02-10 00:00:00"
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
        let dateFromString : NSDate = dateFormatter.date(from: date)! as Date as NSDate
        dateFormatter.dateFormat = "dd-MM-yyyy"
        let datenew = dateFormatter.string(from: dateFromString as Date)
        
        return datenew
    }
    
    
    
}
