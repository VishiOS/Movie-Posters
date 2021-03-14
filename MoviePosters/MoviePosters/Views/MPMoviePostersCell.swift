//
//  MoviePostersCell.swift
//  MoviePosters
//
//  Created by Vishal22 Sharma on 13/03/21.
//

import UIKit
import Kingfisher

class MPMoviePostersCell: UICollectionViewCell {
    static let cellIdentifier = "MPMoviePostersCell"
    @IBOutlet weak var posterImage: UIImageView!
    //@IBOutlet weak var titleLabel: UILabel!
    
    var movie: Movie? {
        didSet {
            //titleLabel.text = movie?.title
            //overviewLabel.text = movie?.overview
            let placeholderImage = UIImage(named: "placeholder")
            if let moviePoster = movie?.posterUrl() {
                posterImage.kf.setImage(with: moviePoster, placeholder: placeholderImage)
            } else {
                posterImage.image = placeholderImage
            }
        }
    }
}
