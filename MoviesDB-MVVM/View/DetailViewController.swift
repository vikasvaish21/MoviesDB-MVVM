//
//  DetailViewController.swift
//  MoviesDB-MVVM
//
//  Created by Vikas Vaish on 27/07/22.
//

import Foundation
import NVActivityIndicatorView

protocol DetailOutputVC: AnyObject{
    func saveDetails(detail: MoviesDetail)
    func saveSimilarMovies(movies: [MovieInfo])
    func changeisLoading(isloading : Bool)
}

class DetailViewController: UIViewController {
    var id : Int = 0
    let headerView = UIView()
    var viewModel =  DetailViewModel()
    var collectionView : UICollectionView!
    var contentView = UIView()
    let scrollView = UIScrollView()
    var similarMoviesTitle = MyLabel(textSize: 30, color: .white, alignment: .left)
    var similarMovieList = [MovieInfo]()
    var activityIndicatorView = NVActivityIndicatorView(frame: .zero, type: .circleStrokeSpin, color: .systemRed, padding: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemGray6
        viewModel.detailOutput = self
        viewModel.fetchDetail(moviesID: id)
        viewModel.fetchSimilarMovies(moviesID: id)
        configureIndicatorView()
        configureHeaderView()
        configureCollectionView()
    }
    
    func configureCollectionView() {
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UIHelper.createColumnFlowLayout(view: view))
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(collectionView)
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(SimilarCell.self, forCellWithReuseIdentifier: SimilarCell.reuseId)
        
        
        scrollView.anchor(top: view.topAnchor, bottom: view.bottomAnchor)
        scrollView.centerX(inView: view)
        scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        
        contentView.anchor(top: scrollView.topAnchor, bottom: scrollView.bottomAnchor)
        contentView.centerX(inView: scrollView)
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.anchor(top: similarMoviesTitle.bottomAnchor, left: contentView.leftAnchor, bottom: contentView.bottomAnchor, right: contentView.rightAnchor, height: 250)
    }
    
    func configureIndicatorView() {
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(activityIndicatorView)
        activityIndicatorView.pinToCentre(superView: contentView)
    }
    
    func configureHeaderView() {
        contentView.addSubview(headerView)
        contentView.addSubview(similarMoviesTitle)
        similarMoviesTitle.text = "Similar Movies"
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.anchor(top: contentView.safeAreaLayoutGuide.topAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor,  paddingLeft: 10, paddingRight: 10,height: 350)
        similarMoviesTitle.anchor(top: headerView.bottomAnchor, left: contentView.leftAnchor, right: contentView.rightAnchor, paddingTop: 50, paddingLeft: 10, paddingRight: 10, height: 34)
    }
    
    func configureUIelement(detail: MoviesDetail) {
        DispatchQueue.main.async {
            let header = DetailHeaderViewController(detail: detail)
            self.add(childVC: header, containerView: self.headerView)
        }
    }
    
    func add(childVC: UIViewController,containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
}

extension DetailViewController: DetailOutputVC{
    func saveSimilarMovies(movies: [MovieInfo]) {
        DispatchQueue.main.async {
            self.similarMovieList = movies
            self.collectionView.reloadData()
        }
    }
    
    func changeisLoading(isloading: Bool) {
        isloading ? activityIndicatorView.startAnimating() : activityIndicatorView.stopAnimating()
        
        if isloading {
            activityIndicatorView.startAnimating()
        }else {
            activityIndicatorView.stopAnimating()
        }
    }
    
    
    func saveDetails(detail: MoviesDetail) {
        configureUIelement(detail: detail)
    }
}

extension DetailViewController: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return similarMovieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SimilarCell.reuseId, for: indexPath) as! SimilarCell
        let imagePath  = similarMovieList[indexPath.item].posterPath
        cell.setup(imagePath: imagePath)
        return cell
    }
}
extension DetailViewController: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.id = similarMovieList[indexPath.item].id
        navigationController?.pushViewController(detailVC, animated: true)
        
    }
}
