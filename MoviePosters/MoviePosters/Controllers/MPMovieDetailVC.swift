//
//  MPMovieDetailVC.swift
//  MoviePosters
//
//  Created by Vishal22 Sharma on 14/03/21.
//

import UIKit

class MPMovieDetailVC: UIViewController {
    
    let viewModel = MPMovieDetailViewModel()
    var movie: Movie?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewTextView: UITextView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViewProperties()
        // Do any additional setup after loading the view.
    }
    func setupViewProperties(){
        self.fetchReleaseDates()
        self.setBackButton()
        self.title = "Movie Detail"
        guard let movie = movie else { return }
        titleLabel.text = movie.title
        overviewTextView.text = movie.overview
        ratingLabel.text = "\(movie.rating)"
        let placeholderImage = UIImage(named: "placeholder")
        if let moviePoster = movie.posterUrl() {
            posterImage.kf.setImage(with: moviePoster, placeholder: placeholderImage)
        } else {
            posterImage.image = placeholderImage
        }
    }
    func setBackButton() {
        let bakButton  = UIBarButtonItem(image: UIImage(named: "back_arrow_black"), style: .plain, target: self, action: #selector(backButtonTapped))
        self.navigationItem.leftBarButtonItem = bakButton

    }
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func fetchReleaseDates() {
        self.viewModel.fetchReleaseDates(movie: self.movie) { (dateString, error) in
            DispatchQueue.main.async{
                self.releaseDateLabel.text = dateString
            }
        }
    }
}
