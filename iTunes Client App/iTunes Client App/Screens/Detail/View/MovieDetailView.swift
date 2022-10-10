//
//  MovieDetailView.swift
//  iTunes Client App
//
//  Created by Eymen Varilci on 9.10.2022.
//
import CoreData
import UIKit

final class MovieDetailView: UIView {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var movieName: String? {
        didSet {
            movieNameKeyLabel.text = "Movie Name:"
//            releaseDateKeyLabel.textAlignment = .left
            movieNameKeyLabel.font = .boldSystemFont(ofSize: 17.0)
            movieNameLabel.text = movieName ?? "-"
//            releaseDateLabel.textAlignment = .right
        }
    }
    
    var directorName: String? {
        didSet {
            directorNameKeyLabel.text = "Director Name:"
//            artistNameKeyLabel.textAlignment = .left
            directorNameKeyLabel.font = .boldSystemFont(ofSize: 17.0)
            directorNameLabel.text = directorName ?? "-"
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
    
    var genreName: String? {
        didSet {
            genreNameKeyLabel.text = "Genre:"
//            genresKeyLabel.textAlignment = .left
            genreNameKeyLabel.font = .boldSystemFont(ofSize: 17.0)
            genreNameLabel.text = genreName ?? "-"
//            genresLabel.textAlignment = .right
        }
    }
    var movieDescription: String? {
        didSet {
            descriptionKeyLabel.text = "description:"
//            genresKeyLabel.textAlignment = .left
            descriptionKeyLabel.font = .boldSystemFont(ofSize: 17.0)
            descriptionLabel.text = movieDescription ?? "-"
//            genresLabel.textAlignment = .right
        }
    }
    
    private(set) var imageView = UIImageView()
    
    private let movieNameKeyLabel = UILabel()
    private let movieNameLabel = UILabel()
    private lazy var trackNameStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [movieNameKeyLabel, UIView(), movieNameLabel])
        stackView.axis = .horizontal
        return stackView
    }()
    
    private var directorNameKeyLabel = UILabel()
    private var directorNameLabel = UILabel()
    private lazy var artistNameStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [directorNameKeyLabel, UIView(), directorNameLabel])
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
    
    private var genreNameKeyLabel = UILabel()
    private var genreNameLabel = UILabel()
    private lazy var genresStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [genreNameKeyLabel, UIView(), genreNameLabel])
        stackView.axis = .horizontal
        return stackView
    }()
    
    private var descriptionKeyLabel = UILabel()
    private var descriptionLabel = UILabel()
    private lazy var descriptionStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [descriptionKeyLabel, UIView(), descriptionLabel])
        stackView.axis = .horizontal
        return stackView
    }()
    
    private var favoritesButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .lightGray
        
        movieNameLabel.numberOfLines = .zero
        directorNameLabel.numberOfLines = .zero
        countryLabel.numberOfLines = .zero
        genreNameLabel.numberOfLines = .zero
        descriptionLabel.numberOfLines = .zero
        
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
        
        let stackView = UIStackView(arrangedSubviews: [trackNameStackView,
                                                       artistNameStackView,
                                                       countryStackView,
                                                       genresStackView,
                                                      descriptionStackView])
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
    
    @objc func addFavorites() {
        // add selected music to core data
        let imageData = imageView.image!.jpegData(compressionQuality: 0.7)
            let newMovie = NSEntityDescription.insertNewObject(forEntityName: "MovieEntity", into: context)


        newMovie.setValue(imageData, forKey: "artwork")
        newMovie.setValue(movieNameLabel.text!, forKey: "movieName")
        newMovie.setValue(directorNameLabel.text!, forKey: "director")
        newMovie.setValue(countryLabel.text!, forKey: "country")
        newMovie.setValue(genreNameLabel.text!, forKey: "genre")
        newMovie.setValue(UUID(), forKey: "id")
        
        do {
            try context.save()
            print("to favrite added")
            
        } catch {
            print("can not save movie")
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
      
        
        
    }
}

