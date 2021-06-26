//
//  DotView.swift
//  SunVault
//
//  Created by Bryan Work on 6/24/21.
//

import UIKit

@IBDesignable class DotView: UIView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.width / 2
        layer.borderWidth = 3
        layer.borderColor = UIColor.black.cgColor
        //layer.backgroundColor = UIColor(red: 255/255.0, green: 204/255.0, blue: 51/255.0, alpha: 0.2).cgColor
        layer.backgroundColor = UIColor(white: 1, alpha: 1).cgColor
        
    }
    init(frame: CGRect, title: Int) {
        super.init(frame: frame)
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
}
