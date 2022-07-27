//
//  NetworkingManager.swift
//  MoviesDB-MVVM
//
//  Created by Vikas Vaish on 25/07/22.
//

import Foundation
import Alamofire
enum ServiceType:String{
    case popular = "popular"
    case topRated = "top_rated"
    case upcoming = "upcoming"
    case latest  = "now_playing"
}

class NetworkingManager {
    static var shared = NetworkingManager()
    let baseURL = "https://api.themoviedb.org/3/movie/"
    let languageAndPage = "&language=en-US&page=1#"
    typealias completionHandler = ([MovieInfo]?,String?) -> Void
    
    init(){
        
    }
    
    func getMoviesData(_ serviceType: ServiceType,completionHandler: @escaping completionHandler)  {
        let endUrl = baseURL + "\(serviceType.rawValue)?api_key=137197c411da84dfd533942e78cd8036" + languageAndPage
        let request = AF.request(endUrl)
        request.validate().responseDecodable(of: MovieData.self) { response in
            switch response.result{
            case .success(let movieInfo):
                completionHandler(movieInfo.results, nil)
            case .failure(let error):
                completionHandler(nil, error.localizedDescription)
            }
        }
    }
    
    typealias completionHandler1 = (MoviesDetail?,String?) -> Void
    func getMoviesDetail(id: Int,completionHandler: @escaping completionHandler1)  {
        let endUrl = baseURL + "\(id)?api_key=137197c411da84dfd533942e78cd8036" + languageAndPage
        let request = AF.request(endUrl)
        request.validate().responseDecodable(of: MoviesDetail.self) { response in
            switch response.result{
            case .success(let movieInfo):
                completionHandler(movieInfo, nil)
            case .failure(let error):
                completionHandler(nil, error.localizedDescription)
            }
        }
    }
    
    func getSimilarMovies(id: Int,completionHandler: @escaping completionHandler)  {
        let endUrl = baseURL + "\(id)/similar?api_key=137197c411da84dfd533942e78cd8036" + languageAndPage
        let request = AF.request(endUrl)
        request.validate().responseDecodable(of: MovieData.self) { response in
            switch response.result{
            case .success(let movieInfo):
                completionHandler(movieInfo.results, nil)
            case .failure(let error):
                completionHandler(nil, error.localizedDescription)
            }
        }
    }
    
    func getImage(_ url: String,completionHandler: @escaping (UIImage?,String?) -> Void)  {
        let request = AF.request(url)
        request.responseData{ response in
            switch response.result{
            case .success:
                guard let imageData = response.value,let image = UIImage(data: imageData,scale: 1.0) else{
                    return
                }
                completionHandler(image,nil)
            case .failure(let error):
                completionHandler(nil,error.errorDescription)
            }
        }
    }

    
    
}
