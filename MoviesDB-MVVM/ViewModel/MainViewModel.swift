//
//  MainViewModel.swift
//  MoviesDB-MVVM
//
//  Created by Vikas Vaish on 25/07/22.
//

import Foundation
class MainViewModel {
    var isLoading : Bool = false
    weak var mainVCOutPut: MainVCOutPut?
    
    func fetchData(){
        let dispatchGroup = DispatchGroup()
        changeLoading()
        dispatchGroup.enter()
        NetworkingManager.shared.getMoviesData(.popular) { [weak self] moviesInfo, error in
            guard error == nil else{
                print(error)
                dispatchGroup.leave()
                return
            }
            self?.mainVCOutPut?.saveMovies(moviesType: .popularMovies, list: moviesInfo!)
            dispatchGroup.leave()
        }
        
        // MARK: - TOP RATED MOVIES
        dispatchGroup.enter()
        NetworkingManager.shared.getMoviesData(.topRated) { moviesInfo, error in
            guard error == nil else{
                print(error)
                dispatchGroup.leave()
                return
            }
            self.mainVCOutPut?.saveMovies(moviesType: .topRatedMovies, list: moviesInfo!)
            dispatchGroup.leave()
        }
        
        // MARK: - UPCOMING MOVIES
        dispatchGroup.enter()
        NetworkingManager.shared.getMoviesData(.upcoming) { moviesInfo, error in
            guard error == nil else{
                print(error)
                dispatchGroup.leave()
                return
            }
            self.mainVCOutPut?.saveMovies(moviesType: .upcomingMovies, list: moviesInfo!)
            dispatchGroup.leave()
        }
        
        // MARK: - LATEST MOVIES
        dispatchGroup.enter()
        NetworkingManager.shared.getMoviesData(.latest) { moviesInfo, error in
            guard error == nil else{
                print(error)
                dispatchGroup.leave()
                return
            }
            self.mainVCOutPut?.saveMovies(moviesType: .latestMovies, list: moviesInfo!)
            dispatchGroup.leave()
        }
        
        dispatchGroup.notify(queue: .main){
            self.changeLoading()
        }
    }
    
    func changeLoading(){
        isLoading = !isLoading
        self.mainVCOutPut?.changeLoadingAndReloadData(isLoading: self.isLoading)
    }
    
    
}
