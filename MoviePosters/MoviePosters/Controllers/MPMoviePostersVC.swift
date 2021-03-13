//
//  MPMoviePostersVC.swift
//  MoviePosters
//
//  Created by Vishal22 Sharma on 13/03/21.
//

import UIKit

class MPMoviePostersVC: UIViewController {
    let viewModel = MPMoviePostersViewModel()
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
