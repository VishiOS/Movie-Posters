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
        // Do any additional setup after loading the view.
    }
    func setupViewProperties() {
        self.title = "Movie Posters"
        self.moviePostersCollectionView.delegate = viewModel
        self.moviePostersCollectionView.dataSource = viewModel
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
