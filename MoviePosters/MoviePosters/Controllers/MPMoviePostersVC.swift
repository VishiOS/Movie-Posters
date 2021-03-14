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
        self.addSortButton()
        self.title = "Movie Posters"
        self.moviePostersCollectionView.delegate = viewModel
        self.moviePostersCollectionView.dataSource = viewModel
        
        self.openMoviewDetailVC()
    }
    func addSortButton() {
        let bakButton  = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(sortButtonTapped))
        self.navigationItem.rightBarButtonItem = bakButton

    }
    @objc func sortButtonTapped() {
        self.searchBar.resignFirstResponder()
        searchBar.setShowsCancelButton(false, animated: true)
        let actionSheetControllerIOS8: UIAlertController = UIAlertController(title: "Please select", message: "Option to Sort Movies", preferredStyle: .actionSheet)

            let cancelActionButton = UIAlertAction(title: "Cancel", style: .cancel) { _ in
            }
            actionSheetControllerIOS8.addAction(cancelActionButton)

            let defaultActionButton = UIAlertAction(title: "Now Playing / Default", style: .default)
                { _ in
                self.viewModel.isSorting = true
                self.viewModel.sortType = eApiName.nowPlayingServicePath
                self.viewModel.sendRequestToFetchMoviesList()
            }
            actionSheetControllerIOS8.addAction(defaultActionButton)

            let popularActionButton = UIAlertAction(title: "Popular Movies", style: .default)
                { _ in
                self.viewModel.isSorting = true
                self.viewModel.sortType = eApiName.moviePopular
                self.viewModel.sendRequestToFetchMoviesList()
            }
            actionSheetControllerIOS8.addAction(popularActionButton)
        
        let ratedActionButton = UIAlertAction(title: "Highest Rated Movies", style: .default)
            { _ in
            self.viewModel.isSorting = true
            self.viewModel.sortType = eApiName.topRatedMovie
            self.viewModel.sendRequestToFetchMoviesList()
        }
        actionSheetControllerIOS8.addAction(ratedActionButton)
            self.present(actionSheetControllerIOS8, animated: true, completion: nil)
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
        let searchedArr: Bindable<[Movie]> = Bindable([])
        
        for item in self.viewModel.nowPlayingList.value {
            if let title = item.title, title.contains(searchText) {
                searchedArr.value.append(item)
            }
        }
        self.viewModel.searchArray = searchedArr
        self.reloadmoviePostersCollectionView()
    }
}
