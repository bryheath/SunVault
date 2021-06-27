//
//  AlbumCell.swift
//  SunVault
//
//  Created by Bryan Work on 6/25/21.
//

import UIKit

class AlbumCell: UITableViewCell {
    
    let albumThumbnail: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "square"))
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let albumNameLabel: UILabel = {
       let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textAlignment = .right
        label.backgroundColor = .gray
        return label
        
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        albumNameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(albumThumbnail)
        addSubview(albumNameLabel)
        
        
        albumThumbnail.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: nil, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 90, height: 90, enableInsets: false)
        
        
        albumNameLabel.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor).isActive = true
        albumNameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -10).isActive = true
        albumNameLabel.leftAnchor.constraint(equalTo: albumThumbnail.rightAnchor, constant: 10).isActive = true
        
    }
    
    
    
}
