//
//  FavoritesViewController.swift
//  iTunes Client App
//
//  Created by Eymen Varilci on 10.10.2022.
//

import UIKit

final class FavoritesViewController: UIViewController {

    let FavView = FavoritesView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        view = FavView
        
        FavView.setTableViewDelegates(delegate: self, datasource: self)
        
    }
   
    
}

extension FavoritesViewController: UITableViewDelegate {
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Codes below should pass the id and name to match the exact choosen inhalt
        
//     let nextVC = FavoritesDetailView()
//        let detailvc = FavoritesDetailViewController()
//        FavView.selected = FavView.nameArray[indexPath.row]
//        FavView.selectedId = FavView.idArray[indexPath.row]
//        nextVC.choosen = FavView.selected
//        nextVC.choosenId = FavView.selectedId
//        navigationController?.pushViewController(detailvc, animated: true)
        
        
        
    }
}

extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FavView.nameArray.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = FavView.nameArray[indexPath.row]
        return cell
    }
    
}
