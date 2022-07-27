//
//  UIHelper.swift
//  MoviesDB-MVVM
//
//  Created by Vikas Vaish on 25/07/22.
//

import Foundation
import UIKit
enum MoviesType: String,CaseIterable{
    case popularMovies =  "Popular Movies"
    case topRatedMovies = "Top Rated Movies"
    case upcomingMovies = "Upcoming Movies"
    case latestMovies = "Latest Movies"
}

struct CellItem{
    let cellType: MoviesType
    let moviesList : [MovieInfo]
}

enum UIHelper {
    //MARK: MainVC collectionView Layouts Settings
    static func createLayouts() -> UICollectionViewLayout {
        UICollectionViewCompositionalLayout { sectionIndex, _ in
            
            switch sectionIndex {
            case 0:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets.trailing = 10
                item.contentInsets.leading = 2
                item.contentInsets.bottom = 10
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.60), heightDimension: .absolute(300)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                let headerKind = UICollectionView.elementKindSectionHeader
                section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40)), elementKind: headerKind, alignment: .topLeading)]
                return section
                
            case 1:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.90), heightDimension: .absolute(150)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.top = 10
                section.contentInsets.bottom = 10
                section.orthogonalScrollingBehavior = .continuous
                let headerKind = UICollectionView.elementKindSectionHeader
                section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40)), elementKind: headerKind, alignment: .topLeading)]
                return section
                
            case 2:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets.leading = 5
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.30), heightDimension: .absolute(150)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.top = 10
                section.contentInsets.leading = 2
                section.orthogonalScrollingBehavior = .continuous
                let headerKind = UICollectionView.elementKindSectionHeader
                section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40)), elementKind: headerKind, alignment: .topLeading)]
                return section
                
            case 3:
                let item = NSCollectionLayoutItem(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1)))
                item.contentInsets.leading = 5
                let group = NSCollectionLayoutGroup.horizontal(layoutSize: .init(widthDimension: .fractionalWidth(0.30), heightDimension: .absolute(150)), subitems: [item])
                let section = NSCollectionLayoutSection(group: group)
                section.contentInsets.top = 10
                section.contentInsets.leading = 2
                section.orthogonalScrollingBehavior = .continuous
                let headerKind = UICollectionView.elementKindSectionHeader
                section.boundarySupplementaryItems = [.init(layoutSize: .init(widthDimension: .fractionalWidth(1), heightDimension: .absolute(40)), elementKind: headerKind, alignment: .topLeading)]
                return section
            default:
                fatalError()
            }
        }
    }
    static func createColumnFlowLayout(view : UIView) -> UICollectionViewFlowLayout{
         
         let width                       = view.bounds.width
         let padding:CGFloat             = 12
         let minimumItemSpacing:CGFloat  = 10
         let availableWidth              = width - (padding) - (minimumItemSpacing)
         let itemWidth                   = availableWidth / 3
         
         let flowLayout                  = UICollectionViewFlowLayout()
         flowLayout.scrollDirection      = .horizontal
         flowLayout.sectionInset         = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
         flowLayout.itemSize             = CGSize(width: itemWidth + 20, height: itemWidth + 80)
         
         return flowLayout
     }
}

extension UIView{
    func anchor(top: NSLayoutYAxisAnchor? = nil,left: NSLayoutXAxisAnchor? = nil,bottom: NSLayoutYAxisAnchor? = nil,right: NSLayoutXAxisAnchor? = nil,paddingTop: CGFloat = 0,paddingLeft:CGFloat = 0,paddingBottom:CGFloat = 0,paddingRight:CGFloat = 0,width: CGFloat? = nil,height : CGFloat? = nil){
        
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top {
            topAnchor.constraint(equalTo: top,constant: paddingTop).isActive = true
        }
        if let left = left {
            leftAnchor.constraint(equalTo: left,constant: paddingLeft).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom,constant: -paddingBottom).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right,constant: -paddingRight).isActive = true
        }
        if let width = width {
            widthAnchor.constraint(equalToConstant : width).isActive = true
        }
        if let height = height {
            heightAnchor.constraint(equalToConstant : height).isActive = true
        }
    }
    
    func centerX(inView view: UIView) {
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    func centerY(inView view: UIView,constant:CGFloat = 0) {
        centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    
    func addSubViews(view: UIView...){
        view.forEach { view in
            addSubview(view)
        }
    }
    
    func pinToEdges(superView: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        anchor(top: superView.safeAreaLayoutGuide.topAnchor, left: superView.leftAnchor, bottom: superView.bottomAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 0, paddingBottom: 0, paddingRight: 0)
    }
    
    func pinToCentre(superView:  UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        centerX(inView: superView)
        centerY(inView: superView)
        anchor(width: 50, height: 50)
    }
}
extension UIViewController{
    func makeDarkModeAllView(){
        UIApplication.shared.windows.forEach { window in
            window.overrideUserInterfaceStyle = .dark
        }
    }
}

