//
//  MusicViewController.swift
//  iTunes Client App
//
//  Created by Eymen Varilci on 6.10.2022.
//

import UIKit

final class MusicViewController: UIViewController {

    private let musicView = MusicView()
    private let networkService = BaseNetworkService()
    private var musicResponse : MusicResponse? {
        didSet {
            musicView.refresh()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.backgroundColor = .white
        
        view = musicView
        musicView.setCollectionViewDelegate(self, andDataSource: self)
        let searchController = UISearchController()
        searchController.searchBar.placeholder = "Track, Album, Artist"
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        
       
        
        
        
      fetchMusics()
    }
    
    private func fetchMusics(with text: String = "Music") {
        networkService.request(MusicRequest(searchText: text)) { result in
            switch result {
            case .success(let response):
                self.musicResponse = response
            case .failure(let error):
                fatalError(error.localizedDescription)
            }
        }
    }
    
}

extension MusicViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let musicDetalVC = MusicDetailViewController()
        musicDetalVC.music = musicResponse?.results?[indexPath.row]
        navigationController?.pushViewController(musicDetalVC, animated: true)
    }
}

extension MusicViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        musicResponse?.results?.count ?? .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "musicCell", for: indexPath) as! MusicCollectionViewCell
        let music = musicResponse?.results?[indexPath.row]
        cell.title = music?.trackName
        cell.imageView.downloadImage(from: music?.artwork)
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        collectionView.reloadItems(at: [indexPath])
    }
    
    
}

extension MusicViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, text.count > 1 {
            fetchMusics(with: text)
        }
    }
}

