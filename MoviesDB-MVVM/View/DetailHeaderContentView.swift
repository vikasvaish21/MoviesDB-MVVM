//
//  DetailHeaderContentView.swift
//  MoviesDB-MVVM
//
//  Created by Vikas Vaish on 27/07/22.
//

import Foundation
import UIKit
class DetailHeaderContentView: UIView {
    let imageView = UIImageView()
    let label = MyLabel(textSize: 15, color: .white, alignment: .left)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setLabelText(text: String,systemImage: String) {
        label.text = text
        imageView.image = UIImage(systemName: systemImage)?.withTintColor(.systemOrange,renderingMode: .alwaysOriginal)
        configure()
    }
    
    private func configure() {
        addSubViews(view: imageView,label)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.anchor(left: leftAnchor, width: 20, height: 20)
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        label.anchor(left: imageView.rightAnchor, right: rightAnchor,paddingLeft: 5, height: 20)
        label.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
}
