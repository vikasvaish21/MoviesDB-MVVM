//
//  SimilarCell.swift
//  MoviesDB-MVVM
//
//  Created by Vikas Vaish on 27/07/22.
//

import UIKit

class SimilarCell: UICollectionViewCell {
 
    static var reuseId = "SimilarCell"
    
    let imageView = MyImage(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemneted")
    }
    
    func setup(imagePath:String) {
        imageView.downloadImage(posterPath: imagePath)
    }

    
    func configure() {
        addSubview(imageView)
        imageView.anchor( paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0, width: 120, height: 180)
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        layer.cornerRadius = 10
        clipsToBounds = true
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0.5)
        layer.shadowOpacity = 0.2
        
    }
    
    
}
