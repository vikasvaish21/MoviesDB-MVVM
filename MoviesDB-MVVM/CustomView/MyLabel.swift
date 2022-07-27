//
//  MyLabel.swift
//  MoviesDB-MVVM
//
//  Created by Vikas Vaish on 26/07/22.
//

import UIKit

class MyLabel: UILabel {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init (textSize: CGFloat,color: UIColor,alignment:NSTextAlignment){
        self.init(frame: .zero)
        font = UIFont.init(font: .helveticaBold, size: textSize)
        textColor = color
        numberOfLines = 0
        textAlignment = alignment
        
    }
    
    private func configure(){
        translatesAutoresizingMaskIntoConstraints = false
    }
}
