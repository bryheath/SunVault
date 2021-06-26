//
//  MainViewController.swift
//  SunVault
//
//  Created by Bryan Work on 6/24/21.
//

import UIKit

class MainViewController: UITableViewController {
    var albums: [Album] = [Album]()
    let cellID = "cellID"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.blue
        self.title = "Photo Albums"
        createExampleAlbums()
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.separatorStyle = .none
        
        tableView.register(AlbumCell.self, forCellReuseIdentifier: cellID)
        
    
        
        let fileManager = FileManager.default
        let pathComponent: String = "/folder1"
        let directoryURL: URL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        
        let fileURL: URL = directoryURL.appendingPathComponent(pathComponent)
        
        
        
        do {
            try fileManager.createDirectory(atPath: fileURL.path, withIntermediateDirectories: false, attributes: nil)
            print("directory created /folder1")
        } catch {
            print("Error: \(error.localizedDescription)")
        }
        
        
        
        
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! AlbumCell
        cell.layoutMargins = UIEdgeInsets.zero
        let lastItem = albums[indexPath.row]
        cell.album = lastItem
        return cell
    }
    
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 0
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func createExampleAlbums() {
        albums.append(Album(name: "Untitled Album", thumbnail: #imageLiteral(resourceName: "square")))
    }
}
