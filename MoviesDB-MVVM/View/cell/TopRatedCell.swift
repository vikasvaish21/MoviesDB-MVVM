//
//  TopRatedCell.swift
//  MoviesDB-MVVM
//
//  Created by Vikas Vaish on 26/07/22.
//

import UIKit
import UIFontComplete
class TopRatedCell : UICollectionViewCell{
    
    
    static var reuseId = "TopRatedCell"
    
    
    let view = UIView()
    let imageView = MyImage(frame: .zero)
    let titleLabel = MyLabel(textSize: 18, color: .label, alignment: .left)
    let imdbLabel = MyLabel(textSize: 18, color: .systemOrange, alignment: .center)
    let releaseLabel = MyLabel(textSize: 18, color: .systemOrange, alignment: .left)
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemneted")
    }
    
    func setup(movieInfo: MovieInfo) {
        imageView.downloadImage(posterPath: movieInfo.posterPath)
        titleLabel.text = movieInfo.title
        imdbLabel.text = "\(movieInfo.voteAverage)"
        releaseLabel.text = movieInfo.releaseDate
    }
    


    private func configure() {
        addSubViews(view: view,imageView,titleLabel,imdbLabel,releaseLabel)
        view.translatesAutoresizingMaskIntoConstraints = false
        imageView.translatesAutoresizingMaskIntoConstraints = false
        view.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        view.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        view.widthAnchor.constraint(equalTo: widthAnchor,constant: -30).isActive = true
        view.heightAnchor.constraint(equalToConstant: 120).isActive = true
        imageView.anchor(left: view.leftAnchor,width: 100, height: 150)
        imageView.centerY(inView: view)
        titleLabel.anchor(top: view.topAnchor, left: imageView.rightAnchor, bottom: releaseLabel.topAnchor, right: view.rightAnchor, paddingTop: 0, paddingLeft: 10, paddingBottom: 0, paddingRight: 0)
        imdbLabel.anchor(bottom: view.bottomAnchor, right: view.rightAnchor, paddingRight: 5, width: 40, height: 40)
        releaseLabel.anchor(left: titleLabel.leftAnchor, bottom: view.bottomAnchor, right: imdbLabel.leftAnchor, height: 40)
        imageView.bringSubviewToFront(view)
        view.backgroundColor = .systemGray5
        view.layer.cornerRadius = 10
        
    }
    
    
}
