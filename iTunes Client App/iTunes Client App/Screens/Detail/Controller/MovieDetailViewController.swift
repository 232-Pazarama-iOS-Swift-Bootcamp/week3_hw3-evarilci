//
//  MovieDetailViewController.swift
//  iTunes Client App
//
//  Created by Eymen Varilci on 9.10.2022.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    var movie: Movie? {
        didSet {
            title = movie?.movieName
            detailView.imageView.downloadImage(from: movie?.artwork)
            detailView.movieName = movie?.movieName
            detailView.directorName = movie?.director
            detailView.country = movie?.country
            detailView.genreName = movie?.genre
        }
    }
    
    private let detailView = MovieDetailView()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
            view = detailView
        
    }
}
