//
//  MoviePostersViewModel.swift
//  MoviePosters
//
//  Created by Vishal22 Sharma on 13/03/21.
//

import UIKit

class MPMoviePostersViewModel: NSObject {
    typealias completionHandller = (Bool) -> Void
    var completion: completionHandller?
    
    typealias completionHandllerForDetailView = (Movie) -> Void
    var completionForDedailView: completionHandllerForDetailView?
    private (set) var state: Bindable<FetchingServiceState> = Bindable(.loading)
    private let webServices: WebServices
    private (set) var nowPlayingList: Bindable<[Movie]> = Bindable([])
    private (set) var currentPage: Int = 1
    private (set) var totalPages: Int = Int.max
    
    init(webServices: WebServices = WebServices()) {
        self.webServices = webServices
    }
    
}
extension MPMoviePostersViewModel: UICollectionViewDataSource, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.nowPlayingList.value.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MPMoviePostersCell.cellIdentifier, for: indexPath as IndexPath) as! MPMoviePostersCell
        cell.movie = self.nowPlayingList.value[indexPath.row]
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("You selected cell #\(indexPath.item)!")
        self.completionForDedailView?(self.nowPlayingList.value[indexPath.row])
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > (scrollView.contentSize.height - scrollView.frame.size.height) && self.state.value != .loading {
            self.sendRequestToFetchMoviesList()
            
        }
    }
    
    func sendRequestToFetchMoviesList() {
        self.fetchNowPlaying { (status, response) in
            if status {
                self.completion?(true)
            }
        }
    }
}
extension MPMoviePostersViewModel{
    func fetchNowPlaying(completion: @escaping ((_ status: Bool, _ error: Error?) -> ())) {
        if currentPage > totalPages { return }
        state.value = .loading
        
        webServices.getNowPlayingMovies(service: NowPlayingAPI(paramters: [MPNetworkConstants.pageParameterKey: "\(currentPage)"]), completion: { [weak self] response in
            self?.state.value = .finishedLoading
            switch response {
            case .success(let result):
                self?.nowPlayingList.value.append(contentsOf: result.movies)
                self?.totalPages = result.totalPages
                self?.currentPage += 1
                completion(true, nil)
            case .failure(let error):
                self?.state.value = .error(error)
            }
        })
    }
}
