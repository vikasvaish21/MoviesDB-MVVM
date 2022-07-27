//
//  DetailHeaderViewController.swift
//  MoviesDB-MVVM
//
//  Created by Vikas Vaish on 27/07/22.
//

import Foundation
import UIKit
class DetailHeaderViewController : UIViewController {
    let posterImage = MyImage(frame: .zero)
    let titleLabel = MyLabel(textSize: 25, color: .white, alignment: .left)
    let overViewLabel =  MyBodyLabel(textAlignment: .left)
    let genre = DetailHeaderContentView()
    let runtime = DetailHeaderContentView()
    let date = DetailHeaderContentView()
    let stackView = UIStackView()
    var detail : MoviesDetail!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
        set()
    }
    
    init(detail: MoviesDetail) {
        super.init(nibName: nil, bundle: nil)
        self.detail = detail
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set() {
        genre.setLabelText(text: detail.genres[0].name, systemImage: "tag")
        runtime.setLabelText(text: timeConverter(runtime: detail.runtime), systemImage: "clock")
        date.setLabelText(text: dateConverter(date: detail.releaseDate), systemImage: "calender")
        overViewLabel.text = detail.overview
        posterImage.downloadImage(posterPath: detail.posterPath)
        titleLabel.text = detail.title
    }
    
    func configureStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(genre)
        stackView.addArrangedSubview(runtime)
        stackView.addArrangedSubview(date)
        stackView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func configureLayout() {
        view.addSubViews(view: posterImage,titleLabel,stackView,overViewLabel)
        configureStackView()
        posterImage.anchor(top: view.topAnchor, left: view.leftAnchor, width: 100, height: 180)
        titleLabel.anchor(top: posterImage.topAnchor, left: posterImage.rightAnchor, right: view.rightAnchor, paddingLeft: 20)
        stackView.anchor(top: titleLabel.bottomAnchor, left: titleLabel.leftAnchor, right: view.rightAnchor, paddingTop: 5, height: 40)
        overViewLabel.anchor(top: posterImage.bottomAnchor, left: posterImage.leftAnchor, right: stackView.rightAnchor, paddingTop: 10)
        titleLabel.sizeToFit()
    }
    
    func timeConverter(runtime: Int) -> String {
        let hour = runtime / 60
        let minutes = runtime - (hour * 60)
        let result = "\(hour)h \(minutes)m"
        return result
    }
    
    func dateConverter(date: String) -> String {
        let str = Array(date)
        var result = ""
        for i in 0...3{
            result += String(str[i])
        }
        return result
    }
    
    
    
}
