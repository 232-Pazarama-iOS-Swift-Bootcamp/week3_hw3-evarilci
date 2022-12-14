//
//  MovieViewController.swift
//  iTunes Client App
//
//  Created by Eymen Varilci on 9.10.2022.
//

import UIKit

final class MovieViewController: UIViewController {

    private let movieView = MovieView()
    private let networkService = BaseNetworkService()
    private var movieResponse : MovieResponse? {
        didSet {
            movieView.refresh()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .white
        
        view = movieView
        movieView.setCollectionViewDelegate(self, andDataSource: self)
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Movies, Directors"
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        
       
        
        
        
        fetchMovies()
    }
    
    private func fetchMovies(with text: String = "Movie") {
        networkService.request(MovieRequest(searchText: text)) { result in
            switch result {
            case .success(let response):
                self.movieResponse = response
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        }
    }
    
}

extension MovieViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieDetalVC = MovieDetailViewController()
        movieDetalVC.movie = movieResponse?.results?[indexPath.row]
        navigationController?.pushViewController(movieDetalVC, animated: true)
    }
}

extension MovieViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieResponse?.results?.count ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCollectionViewCell
        let movie = movieResponse?.results?[indexPath.row]
        cell.title = movie?.movieName
        cell.imageView.downloadImage(from: movie?.artwork)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        collectionView.reloadItems(at: [indexPath])
    }
    
    
}

extension MovieViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, text.count > 1 {
            fetchMovies(with: text)
        }
    }
}

