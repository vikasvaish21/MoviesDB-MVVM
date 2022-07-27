//
//  MyImage.swift
//  MoviesDB-MVVM
//
//  Created by Vikas Vaish on 26/07/22.
//

import UIKit

class MyImage: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        contentMode = .scaleAspectFill
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        translatesAutoresizingMaskIntoConstraints = false
        clipsToBounds = true
        layer.cornerRadius = 10
        contentMode = .scaleAspectFill
    }
    
    func downloadImage(posterPath: String) {
        let posterURL = "https://image.tmdb.org/t/p/w500" + posterPath
        NetworkingManager.shared.getImage(posterURL) { image, error in
            guard error == nil else{
                return
            }
            self.image = image
        }
    }
}
