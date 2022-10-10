//
//  FavoritesDetailView.swift
//  iTunes Client App
//
//  Created by Eymen Varilci on 10.10.2022.
//

// MARK: - COULD NOT MAKE IT WORK

//import CoreData
//import UIKit
//
//final class FavoritesDetailView: UIView {
//
//    var choosen = ""
//    var choosenId : UUID?
//
//    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
//    var movieName: String? {
//        didSet {
//            movieNameKeyLabel.text = ""
//            //            releaseDateKeyLabel.textAlignment = .left
//            movieNameKeyLabel.font = .boldSystemFont(ofSize: 17.0)
//            movieNameLabel.text = movieName ?? "-"
//            //            releaseDateLabel.textAlignment = .right
//        }
//    }
//
//    var directorName: String? {
//        didSet {
//            directorNameKeyLabel.text = ""
//            //            artistNameKeyLabel.textAlignment = .left
//            directorNameKeyLabel.font = .boldSystemFont(ofSize: 17.0)
//            directorNameLabel.text = directorName ?? "-"
//            //            artistNameLabel.textAlignment = .right
//        }
//    }
//
//    var country: String? {
//        didSet {
//            countryKeyLabel.text = ""
//            //            countryKeyLabel.textAlignment = .left
//            countryKeyLabel.font = .boldSystemFont(ofSize: 17.0)
//            countryLabel.text = country ?? "-"
//            //            countryLabel.textAlignment = .right
//        }
//    }
//
//    var genreName: String? {
//        didSet {
//            genreNameKeyLabel.text = ""
//            //            genresKeyLabel.textAlignment = .left
//            genreNameKeyLabel.font = .boldSystemFont(ofSize: 17.0)
//            genreNameLabel.text = genreName ?? "-"
//            //            genresLabel.textAlignment = .right
//        }
//    }
//    var movieDescription: String? {
//        didSet {
//            descriptionKeyLabel.text = ""
//            //            genresKeyLabel.textAlignment = .left
//            descriptionKeyLabel.font = .boldSystemFont(ofSize: 17.0)
//            descriptionLabel.text = movieDescription ?? "-"
//            //            genresLabel.textAlignment = .right
//        }
//    }
//
//    private(set) var imageView = UIImageView()
//
//    private let movieNameKeyLabel = UILabel()
//    private let movieNameLabel = UILabel()
//    private lazy var trackNameStackView: UIStackView = {
//        let stackView = UIStackView(arrangedSubviews: [movieNameKeyLabel, UIView(), movieNameLabel])
//        stackView.axis = .horizontal
//        return stackView
//    }()
//
//    private var directorNameKeyLabel = UILabel()
//    private var directorNameLabel = UILabel()
//    private lazy var artistNameStackView: UIStackView = {
//        let stackView = UIStackView(arrangedSubviews: [directorNameKeyLabel, UIView(), directorNameLabel])
//        stackView.axis = .horizontal
//        return stackView
//    }()
//
//    private var countryKeyLabel = UILabel()
//    private var countryLabel = UILabel()
//    private lazy var countryStackView: UIStackView = {
//        let stackView = UIStackView(arrangedSubviews: [countryKeyLabel, UIView(), countryLabel])
//        stackView.axis = .horizontal
//        return stackView
//    }()
//
//    private var genreNameKeyLabel = UILabel()
//    private var genreNameLabel = UILabel()
//    private lazy var genresStackView: UIStackView = {
//        let stackView = UIStackView(arrangedSubviews: [genreNameKeyLabel, UIView(), genreNameLabel])
//        stackView.axis = .horizontal
//        return stackView
//    }()
//
//    private var descriptionKeyLabel = UILabel()
//    private var descriptionLabel = UILabel()
//    private lazy var descriptionStackView: UIStackView = {
//        let stackView = UIStackView(arrangedSubviews: [descriptionKeyLabel, UIView(), descriptionLabel])
//        stackView.axis = .horizontal
//        return stackView
//    }()
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        backgroundColor = .lightGray
//
//        movieNameLabel.numberOfLines = .zero
//        directorNameLabel.numberOfLines = .zero
//        countryLabel.numberOfLines = .zero
//        genreNameLabel.numberOfLines = .zero
//        descriptionLabel.numberOfLines = .zero
//
//        addSubview(imageView)
//        imageView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8.0),
//            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
//            imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8.0),
//            imageView.heightAnchor.constraint(equalToConstant: .screenWidth)
//        ])
//        imageView.layer.cornerRadius = 39
//        imageView.clipsToBounds = true
//
//        let stackView = UIStackView(arrangedSubviews: [trackNameStackView,
//                                                       artistNameStackView,
//                                                       countryStackView,
//                                                       genresStackView,
//                                                       descriptionStackView])
//        stackView.axis = .vertical
//        stackView.spacing = 8.0
//        addSubview(stackView)
//        stackView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16.0),
//            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 32.0),
//            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16.0)
//        ])
//        if choosen != "" {
//
//            // core data fetch
//
//            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieEntity")
//            let idString = choosenId?.uuidString
//            fetchRequest.predicate = NSPredicate(format: "id = %@", idString!)
//            fetchRequest.returnsObjectsAsFaults = false
//
//            do{
//                let results = try context.fetch(fetchRequest)
//                if results.count > 0 {
//                    for result in results as! [NSManagedObject] {
//                        if let movName = result.value(forKey: "movieName") as? String {
//                            movieNameLabel.text = movName
//                        }
//                        if let direcName = result.value(forKey: "director") as? String {
//                            directorNameLabel.text = direcName
//                        }
//                        if let coun = result.value(forKey: "country") as? String {
//                            countryLabel.text = coun
//                        }
//                        if let imageData = result.value(forKey: "artwork") as? Data {
//                            let image = UIImage(data: imageData)
//                            imageView.image = image
//                        }
//                        if let about = result.value(forKey: "about") as? String{
//                            descriptionLabel.text = about
//                        }
//                        if let gen = result.value(forKey: "genre") as? String {
//                            genreNameLabel.text = gen
//                        }
//                    }
//                }
//            } catch {
//                print("error")
//
//            }
//
//
//        } else {
//
//        }
//
//    }
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//}
