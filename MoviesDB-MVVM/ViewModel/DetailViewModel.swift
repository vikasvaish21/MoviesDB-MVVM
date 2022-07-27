//
//  DetailViewModel.swift
//  MoviesDB-MVVM
//
//  Created by Vikas Vaish on 27/07/22.
//

import Foundation
class DetailViewModel {
    var similar = [MovieInfo]()
    weak var detailOutput: DetailOutputVC?
    var isLoading: Bool = false
    
    func fetchDetail(moviesID: Int) {
        changeLoading()
        NetworkingManager.shared.getMoviesDetail(id: moviesID) { [weak self] detail, error in
            guard let self = self else{
                return
            }
            guard error == nil else{
                return
            }
            self.detailOutput?.saveDetails(detail: detail!)
            self.changeLoading()
        }
    }
    
    func fetchSimilarMovies(moviesID: Int) {
        NetworkingManager.shared.getSimilarMovies(id: moviesID) { movies, error in
            guard error == nil else{
                return
            }
            self.detailOutput?.saveSimilarMovies(movies: movies!)
        }
        
    }
    
    func changeLoading(){
        isLoading = !isLoading
        self.detailOutput?.changeisLoading(isloading: self.isLoading)
    }
    
}
