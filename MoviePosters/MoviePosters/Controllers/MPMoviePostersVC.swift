//
//  MPMoviePostersVC.swift
//  MoviePosters
//
//  Created by Vishal22 Sharma on 13/03/21.
//

import UIKit

class MPMoviePostersVC: UIViewController {
    
    let viewModel = MPMoviePostersViewModel()
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var moviePostersCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewProperties()
        self.viewModel.sendRequestToFetchMoviesList()
        self.sendRequestToFetchMoviesList()
    }
    func setupViewProperties() {
        self.title = "Movie Posters"
        self.moviePostersCollectionView.delegate = viewModel
        self.moviePostersCollectionView.dataSource = viewModel
        
        
        self.openMoviewDetailVC()
    }
    func openMoviewDetailVC() {
        self.viewModel.completionForDedailView = { movie in
            let controller = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MPMovieDetailVC") as? MPMovieDetailVC
            controller?.movie = movie
            self.searchBar.resignFirstResponder()
            self.navigationController?.pushViewController(controller!, animated: true)
        }
    }
    
    func sendRequestToFetchMoviesList() {
        self.viewModel.completion = { status in
            if status {
                self.reloadmoviePostersCollectionView()
            }
        }
    }
    
    func reloadmoviePostersCollectionView() {
        DispatchQueue.main.async {
            self.moviePostersCollectionView?.reloadData()
        }
    }
    
}
//MARK:- UISearchBarDelegate
extension MPMoviePostersVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.searchMoviews(searchText: searchBar.text ?? "")
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.viewModel.isSearching = false
        self.reloadmoviePostersCollectionView()
        searchBar.text = nil
        searchBar.setShowsCancelButton(false, animated: true)
        searchBar.resignFirstResponder()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        self.searchMoviews(searchText: searchBar.text ?? "")
    }
    func searchMoviews(searchText: String) {
        let searchText = searchBar.text ?? ""
        if searchText.count > 0 {
            self.viewModel.isSearching = true
        }else{
            self.viewModel.isSearching = false
        }
        let arr: Bindable<[Movie]> = Bindable([])
        
        for item in self.viewModel.nowPlayingList.value {
            if let title = item.title, title.contains(searchText) {
                arr.value.append(item)
            }
        }
        self.viewModel.searchArray = arr
        self.reloadmoviePostersCollectionView()
    }
}
