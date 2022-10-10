//
//  FavoritesView.swift
//  iTunes Client App
//
//  Created by Eymen Varilci on 10.10.2022.
//

import UIKit
import CoreData



final class FavoritesView: UIView {
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    private lazy var tableView = UITableView()
    
    private(set) var nameArray = [String]()
    private(set) var idArray = [UUID]()
    

    init() {
        super.init(frame: .zero)
        tableViewConstraints()
        fetchData()
        NotificationCenter.default.addObserver(self, selector: #selector(fetchData), name: NSNotification.Name("newData"), object: nil)
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tableViewConstraints() {
        addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)])
    }
    
    func setTableViewDelegates(delegate Delegate: UITableViewDelegate, datasource DataSource: UITableViewDataSource) {
        
        tableView.delegate = Delegate
        tableView.dataSource = DataSource
        
    }
    
  @objc func fetchData() {
      self.nameArray.removeAll(keepingCapacity: false)
      self.idArray.removeAll(keepingCapacity: false)
      
        let musicRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MusicEntity")
        musicRequest.returnsObjectsAsFaults = false
        
        do {
            let results = try context.fetch(musicRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    if let trackName = result.value(forKey: "trackName") as? String {
                        self.nameArray.append(trackName)
                    }
                    if let id = result.value(forKey: "id") as? UUID {
                        self.idArray.append(id)
                    }
                    self.tableView.reloadData()
                    
                    
                }
            }
            
        } catch {
            print("error")
        }
      
      let movieRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieEntity")
      movieRequest.returnsObjectsAsFaults = false
      
      do {
          let results = try context.fetch(movieRequest)
          if results.count > 0 {
              for result in results as! [NSManagedObject] {
                  if let movieName = result.value(forKey: "movieName") as? String {
                      self.nameArray.append(movieName)
                  }
                  if let id = result.value(forKey: "id") as? UUID {
                      self.idArray.append(id)
                  }
                  self.tableView.reloadData()
                  
                  
              }
          }
          
      } catch {
          print("error")
      }
      
      let podcastRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PodcastEntity")
      podcastRequest.returnsObjectsAsFaults = false
      
      do {
          let results = try context.fetch(podcastRequest)
          if results.count > 0 {
              for result in results as! [NSManagedObject] {
                  if let podcastName = result.value(forKey: "artistName") as? String {
                      self.nameArray.append(podcastName)
                  }
                  if let id = result.value(forKey: "id") as? UUID {
                      self.idArray.append(id)
                  }
                  self.tableView.reloadData()
              }
          }
          
         
      } catch {
          print("error")
      }
        
        
        
    }
    
}
