//
//  MusicDetailViewController.swift
//  iTunes Client App
//
//  Created by Eymen Varilci on 6.10.2022.
//

import UIKit

class MusicDetailViewController: UIViewController {
    
    var music: Music? {
        didSet {
            title = music?.trackName

            detailView.imageView.downloadImage(from: music?.artwork)
            detailView.trackName = music?.trackName
            detailView.artistName = music?.artistName
            detailView.country = music?.country
            detailView.PrimaryGenreName = music?.primaryGenreName
        }
    }
    
    private let detailView = MusicDetailView()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
            view = detailView
       
    }
    

}
