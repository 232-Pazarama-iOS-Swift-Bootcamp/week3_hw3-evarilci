//
//  DetailView.swift
//  iTunes Client App
//
//  Created by Pazarama iOS Bootcamp on 2.10.2022.
//

import UIKit
import CoreData

final class DetailView: UIView {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var releaseDate: String? {
        didSet {
            releaseDateKeyLabel.text = "Release Date:"
//            releaseDateKeyLabel.textAlignment = .left
            releaseDateKeyLabel.font = .boldSystemFont(ofSize: 17.0)
            releaseDateLabel.text = releaseDate ?? "-"
//            releaseDateLabel.textAlignment = .right
        }
    }
    
    var artistName: String? {
        didSet {
            artistNameKeyLabel.text = "Artist Name:"
//            artistNameKeyLabel.textAlignment = .left
            artistNameKeyLabel.font = .boldSystemFont(ofSize: 17.0)
            artistNameLabel.text = artistName ?? "-"
//            artistNameLabel.textAlignment = .right
        }
    }
    
    var country: String? {
        didSet {
            countryKeyLabel.text = "Country:"
//            countryKeyLabel.textAlignment = .left
            countryKeyLabel.font = .boldSystemFont(ofSize: 17.0)
            countryLabel.text = country ?? "-"
//            countryLabel.textAlignment = .right
        }
    }
    
    var genres: String? {
        didSet {
            genresKeyLabel.text = "Genres:"
//            genresKeyLabel.textAlignment = .left
            genresKeyLabel.font = .boldSystemFont(ofSize: 17.0)
            genresLabel.text = genres ?? "-"
//            genresLabel.textAlignment = .right
        }
    }
    
    private(set) var imageView = UIImageView()
    
    private let releaseDateKeyLabel = UILabel()
    private let releaseDateLabel = UILabel()
    private lazy var releaseDateStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [releaseDateKeyLabel, UIView(), releaseDateLabel])
        stackView.axis = .horizontal
        return stackView
    }()
    
    private var artistNameKeyLabel = UILabel()
    private var artistNameLabel = UILabel()
    private lazy var artistNameStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [artistNameKeyLabel, UIView(), artistNameLabel])
        stackView.axis = .horizontal
        return stackView
    }()
    
    private var countryKeyLabel = UILabel()
    private var countryLabel = UILabel()
    private lazy var countryStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [countryKeyLabel, UIView(), countryLabel])
        stackView.axis = .horizontal
        return stackView
    }()
    
    private var genresKeyLabel = UILabel()
    private var genresLabel = UILabel()
    private lazy var genresStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [genresKeyLabel, UIView(), genresLabel])
        stackView.axis = .horizontal
        return stackView
    }()
    
    private var favoritesButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .lightGray
        
        releaseDateLabel.numberOfLines = .zero
        artistNameLabel.numberOfLines = .zero
        countryLabel.numberOfLines = .zero
        genresLabel.numberOfLines = .zero
        
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8.0),
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8.0),
            imageView.heightAnchor.constraint(equalToConstant: .screenWidth)
        ])
        imageView.layer.cornerRadius = 39
        imageView.clipsToBounds = true
        
        let stackView = UIStackView(arrangedSubviews: [releaseDateStackView,
                                                       artistNameStackView,
                                                       countryStackView,
                                                       genresStackView])
        
       
        stackView.axis = .vertical
        stackView.spacing = 8.0
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0),
            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 32.0),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0)
        ])
        
        addSubview(favoritesButton)
        favoritesButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            favoritesButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -10),
            favoritesButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10),
            favoritesButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10),
            favoritesButton.heightAnchor.constraint(equalToConstant: 50)])
        favoritesButton.layer.cornerRadius = 25
        favoritesButton.backgroundColor = .systemBlue
        favoritesButton.setTitle("Add to favorites", for: .normal)
        favoritesButton.addTarget(self, action: #selector(addFavorites), for: .touchUpInside)

       
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: -  Core Data savings
    @objc func addFavorites() {
        // add selected music to core data
            let imageData = imageView.image!.jpegData(compressionQuality: 1.0)
            let newPodcast = NSEntityDescription.insertNewObject(forEntityName: "PodcastEntity", into: context)


        newPodcast.setValue(imageData, forKey: "artwork")
        //newPodcast.setValue(trackNameLabel.text!, forKey: "trackName")
        newPodcast.setValue(artistNameLabel.text!, forKey: "artistName")
        newPodcast.setValue(countryLabel.text!, forKey: "country")
        newPodcast.setValue(genresLabel.text!, forKey: "genre")
        newPodcast.setValue(UUID(), forKey: "id")
        
        do {
            try context.save()
            print("favrite added")
            
        } catch {
            print("can not save music")
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
      
        
        
    }
}
