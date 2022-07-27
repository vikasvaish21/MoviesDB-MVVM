//
//  HeaderViewCell.swift
//  MoviesDB-MVVM
//
//  Created by Vikas Vaish on 27/07/22.
//

import UIKit

class HeaderViewCell: UICollectionViewCell {
    static var reuseid = "HeaderViewCell"
    let label : UILabel = {
        let label  = UILabel()
        label.text = "POPULAR FILMS"
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingLeft: 10)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
