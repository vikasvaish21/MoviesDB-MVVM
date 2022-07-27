//
//  PopularCell.swift
//  MoviesDB-MVVM
//
//  Created by Vikas Vaish on 26/07/22.
//

import UIKit
import UIFontComplete

class PopularCell :UICollectionViewCell{
    
    
    static var reuseId = "PopularCell"
    
    let imageView = MyImage(frame: .zero)
    let label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemneted")
    }
    
    func setup(movie: MovieInfo,itemIndex: Int) {
        imageView.downloadImage(posterPath: movie.posterPath)
        configureLabel(itemIdex: String(itemIndex))
    }
    
    func configureLabel(itemIdex: String) {
        let strokeTextAttributes = [NSAttributedString.Key.strikethroughColor:UIColor.black,NSAttributedString.Key.strokeColor:UIColor.white,NSAttributedString.Key.foregroundColor:UIColor.black,NSAttributedString.Key.strokeWidth: -2.0,NSAttributedString.Key.font : UIFont(font: .helveticaBold, size: 150)!] as [NSAttributedString.Key : Any]
        label.attributedText = NSMutableAttributedString(string: itemIdex,attributes: strokeTextAttributes)
    }
    
    func configure() {
        addSubview(imageView)
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        imageView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 50, paddingRight: 20)
        label.anchor(left: leftAnchor, bottom: bottomAnchor, paddingBottom: 5, width: 250, height: 120)
        layer.cornerRadius = 10
        clipsToBounds = true
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0.5)
        layer.shadowOpacity = 0.2
        
    }
    
    
}
