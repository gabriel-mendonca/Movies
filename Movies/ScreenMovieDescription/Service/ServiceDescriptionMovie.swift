//
//  ServiceDescription.swift
//  Movies
//
//  Created by Gabriel Mendonça on 16/07/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation
import UIKit

enum resultMovieDescription {
    case sucess(movie: MovieDescription?)
    case failure(error: Erro)
}

enum resultMovieVideo {
    case sucess(movieVideo: [MovieVideo])
    case failure(error: Erro)
}

enum ResultRecommendation {
    case sucess(movieRecommendation: [Movie])
    case failure(error: Erro)
}

class ServiceDescriptionMovie: DescriptionEndPoint {
    
    func fetchMovieDescription(id: Int, completion: @escaping( _ result: resultMovieDescription) -> Void) {
        var movie: MovieDescription?
        if Reachability.isConnectedToNetwork(){
            guard let url = URL(string: serviceDescription(id: id)) else {
                return
            }
            URLSession.shared.dataTask(with: url) { data, _, error in
                DispatchQueue.main.async {
                    if error == nil {
                        do {
                            guard let data = data else {
                                return
                            }
                            
                            let descriptionMovie = try JSONDecoder().decode(MovieDescription.self, from: data)
                            print("DESCRIPTIONN = ", descriptionMovie)
                            movie = descriptionMovie
                          completion(resultMovieDescription.sucess(movie: movie))
                        } catch {
                            completion(resultMovieDescription.failure(error: Erro.parseError(error: error.localizedDescription)))
                        }
                    }
                }
            }.resume()
        } else if !Reachability.isConnectedToNetwork() {
            let alert = UIAlertController(title: " ", message: "", preferredStyle: .actionSheet)
            let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
            alert.addAction(ok)
            alert.show(alert, sender: self)
        }
    }
    
    func fetchMovieRecommendations(id: Int, completion: @escaping(_ result: ResultRecommendation) -> Void) {
        var recommendations = [Movie]()
        
        guard let url = URL(string: serviceRecommendations(id: id)) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            DispatchQueue.main.async {
                if error == nil {
                    do {
                        guard let data = data else { return }
                        let movieRecommendations = try JSONDecoder().decode(ListMovie.self, from: data)
                        recommendations = movieRecommendations.results
                        completion(ResultRecommendation.sucess(movieRecommendation: recommendations))
                    } catch {
                        completion(ResultRecommendation.failure(error: Erro.parseError(error: error.localizedDescription)))
                    }
                }
            }
        }.resume()
    }
    
    func fetchMovieVideo(id: Int, completion: @escaping(_ result: resultMovieVideo ) -> Void) {
        var movieVideo = [MovieVideo]()

        guard let url = URL(string: serviceMovieVideo(id: id)) else {
            return
        }

        URLSession.shared.dataTask(with: url) { (data, _, error) in
            DispatchQueue.main.async {
                if error == nil {
                    do {
                        guard let data = data else { return }
                        let video = try JSONDecoder().decode(MovieReponse.self, from: data)
                            movieVideo = video.results
                            completion(resultMovieVideo.sucess(movieVideo: movieVideo))
                    } catch {
                        completion(resultMovieVideo.failure(error: Erro.parseError(error: error.localizedDescription)))
                    }
                }
            }
        }.resume()
    }
}

extension ServiceDescriptionMovie {
    
    func serviceDescription(id: Int) -> String {
        let service = "https://api.themoviedb.org/3/movie/\(id)?api_key=68206fe24af296b2560c51089250d615&language=pt-BR"
        return service
    }
    
    func serviceMovieVideo(id: Int) -> String {
        let serviceVideo = "https://api.themoviedb.org/3/movie/\(id)/videos?api_key=68206fe24af296b2560c51089250d615&language=pt-BR"
        return serviceVideo
    }
    
    func serviceRecommendations(id: Int) -> String {
        let serviceRecommendation = "https://api.themoviedb.org/3/movie/\(id)/recommendations?api_key=68206fe24af296b2560c51089250d615&language=pt-BR&page=1"
        return serviceRecommendation
    }
    
}
