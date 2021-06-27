//
//  MainViewController.swift
//  SunVault
//
//  Created by Bryan Work on 6/24/21.
//

import UIKit

class MainViewController: UITableViewController {
//    var albums: [Album] = [Album]()
    var docDirectories = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let cellID = "cellID"
    var pathComponent: String = ""
    var albums: [String] = [""]
    var thumbnails: [UIImage] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getSubdirs()
        getThumbnails()
        self.view.backgroundColor = UIColor.blue
        self.title = "Photo Albums"
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(createAlbumAlert))
        tableView.layoutMargins = UIEdgeInsets.zero
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.separatorStyle = .none
        
        tableView.register(AlbumCell.self, forCellReuseIdentifier: cellID)
        tableView.dataSource = self
}
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! AlbumCell
        cell.layoutMargins = UIEdgeInsets.zero
        
        cell.albumNameLabel.text = albums[indexPath.row]
        cell.albumThumbnail.image = thumbnails[indexPath.row]
        return cell
    }

    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return albums.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    

    
    
    @objc func createAlbumAlert() {
        let alertController = UIAlertController(title: "Add New Name", message: "", preferredStyle: .alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Enter Album Name"
        }

        

        let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil )
        let createAction = UIAlertAction(title: "Create", style: .default, handler: { alert -> Void in
            let textField = alertController.textFields![0] as UITextField
            self.pathComponent = textField.text!
            print("PathComponent: \(self.pathComponent)")
            self.createAlbum()
            self.tableView.reloadData()
        })

        alertController.addAction(cancelAction)
        alertController.addAction(createAction)
        

        self.present(alertController, animated: true, completion: nil)

    }
    
    func createAlbum() {
        let fileManager = FileManager.default
        let directoryURL: URL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileURL: URL = directoryURL.appendingPathComponent(pathComponent)
        do {
            try fileManager.createDirectory(atPath: fileURL.path, withIntermediateDirectories: false, attributes: nil)
            print("directory created \(fileURL.path)")
            getSubdirs()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
    
    

    func getSubdirs() {
        
        let myDocumentsDirectory = docDirectories[0]

        do {
            let directoryContents = try FileManager.default.contentsOfDirectory(at: myDocumentsDirectory, includingPropertiesForKeys: nil, options: [])

            let subdirs = directoryContents.filter{ $0.hasDirectoryPath }
            albums = subdirs.map{ $0.lastPathComponent }
            albums.sort()

            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func getThumbnails() {
        for n in 0..<albums.count {
            let album = docDirectories[0].appendingPathComponent(albums[n])
//            print("album: \(album)")
            do {
                let directoryContents = try FileManager.default.contentsOfDirectory(at: album, includingPropertiesForKeys: nil, options: [])
                let filter = directoryContents.filter { $0.isFileURL
                    
                }
                var files = filter.map { $0.lastPathComponent}
                files.sort()
//                print("Files: \(files)")
                let url = NSURL(string: files[0])!
//                print("url: \(url)")
                var fullname = album.path
                fullname += "/\(url.path!)"
//                print("fullname: \(fullname)")
                let image = UIImage(contentsOfFile: fullname)
//                print(image!)
                thumbnails.append(image!)
            } catch let error as NSError {
                print(error.localizedDescription)
            }
        }
       
        
        
    }
}
