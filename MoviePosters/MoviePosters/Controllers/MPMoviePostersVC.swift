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
        self.openMoviewDetailVC()
    }
    func openMoviewDetailVC() {
        self.viewModel.completionForDedailView = { movie in
            let controller = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "MPMovieDetailVC") as? MPMovieDetailVC
            controller?.movie = movie
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
