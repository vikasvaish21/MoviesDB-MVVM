//
//  MainViewController.swift
//  MoviesDB-MVVM
//
//  Created by Vikas Vaish on 25/07/22.
//

import UIKit
import NVActivityIndicatorView

protocol MainVCOutPut : AnyObject{
    func saveMovies(moviesType: MoviesType,list: [MovieInfo])
    func changeLoadingAndReloadData(isLoading: Bool)
}

class MainViewController: UIViewController {
    
    
    var collectionView: UICollectionView!
    var collectionCells = [CellItem]()
    
    var popularMoviesList : [MovieInfo] = []
    var latestMoviesList : [MovieInfo] = []
    var upcomingMoviesList : [MovieInfo] = []
    var topRatedMoviesList : [MovieInfo] = []
    lazy var viewModel : MainViewModel = MainViewModel()
    
    var activityIndicationView = NVActivityIndicatorView(frame: .zero,type: .circleStrokeSpin,color: .systemRed,padding: 0)

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        makeDarkModeAllView()
        viewModel.mainVCOutPut = self
        viewModel.fetchData()
        configureCollectionView()
        registerOurCells()
        configureIndicatorView()
        
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: UIHelper.createLayouts())
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemGray6
        collectionView.dataSource = self
        collectionView.delegate = self
    }
    
    func configureIndicatorView() {
        activityIndicationView.translatesAutoresizingMaskIntoConstraints = true
        view.addSubview(activityIndicationView)
        activityIndicationView.pinToCentre(superView: view)
    }
    
    func configureCells() {
        collectionCells = [CellItem(cellType: .popularMovies, moviesList: popularMoviesList),CellItem(cellType: .topRatedMovies, moviesList: topRatedMoviesList),CellItem(cellType: .latestMovies, moviesList: latestMoviesList),CellItem(cellType: .upcomingMovies, moviesList: upcomingMoviesList)]
    }

    func registerOurCells() {
        collectionView.register(PopularCell.self, forCellWithReuseIdentifier: PopularCell.reuseId)
        collectionView.register(TopRatedCell.self, forCellWithReuseIdentifier: TopRatedCell.reuseId)
        collectionView.register(UpcomingCell.self, forCellWithReuseIdentifier: UpcomingCell.reuseId)
        collectionView.register(LatestCell.self, forCellWithReuseIdentifier: LatestCell.reuseId)
        collectionView.register(HeaderViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: HeaderViewCell.reuseid)
    }

}

extension MainViewController: UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return collectionCells.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionCells[section].moviesList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let section =  collectionCells[indexPath.section]
        switch section.cellType{
        case .popularMovies:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PopularCell.reuseId, for: indexPath) as! PopularCell
            let movie = self.popularMoviesList[indexPath.item]
            cell.setup(movie: movie, itemIndex: (indexPath.item + 1) )
            return cell
        case .topRatedMovies:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopRatedCell.reuseId, for: indexPath) as! TopRatedCell
            let movie = self.topRatedMoviesList[indexPath.item]
            cell.setup(movieInfo: movie)
            return cell
        case .upcomingMovies:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UpcomingCell.reuseId, for: indexPath) as! UpcomingCell
            let image = self.upcomingMoviesList[indexPath.item].posterPath
            cell.setup(imagePath: image)
            return cell
        case .latestMovies:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LatestCell.reuseId, for: indexPath) as! LatestCell
            let image = self.latestMoviesList[indexPath.item].posterPath
            cell.setup(imagePath: image)
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerCell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderViewCell.reuseid, for: indexPath) as! HeaderViewCell
        headerCell.label.text = MoviesType.allCases[indexPath.section].rawValue
        return headerCell
    }
    
    
}

extension MainViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.id = collectionCells[indexPath.section].moviesList[indexPath.item].id
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension MainViewController : MainVCOutPut{
    
    func saveMovies(moviesType: MoviesType,list: [MovieInfo]) {
        switch moviesType{
        case .popularMovies:
            popularMoviesList = list
        case .latestMovies:
            latestMoviesList = list
        case .topRatedMovies:
            topRatedMoviesList = list
        case .upcomingMovies:
            upcomingMoviesList = list
        }
        configureCells()
    }
    
    func changeLoadingAndReloadData(isLoading: Bool) {
        if isLoading{
            activityIndicationView.startAnimating()
        } else{
            activityIndicationView.stopAnimating()
            collectionView.reloadData()
        }
    }
}
