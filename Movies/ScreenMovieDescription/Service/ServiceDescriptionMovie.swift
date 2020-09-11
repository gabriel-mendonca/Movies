//
//  ServiceDescription.swift
//  Movies
//
//  Created by Gabriel Mendonça on 16/07/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation

enum resultMovieDescription {
    case sucess(movie: MovieDescription?)
    case failure(error: Erro)
}

protocol DescriptionEndPoint {
    func fetchMovieDescription(id: Int, completion: @escaping( _ result: resultMovieDescription) -> Void)
}

class ServiceDescriptionMovie: DescriptionEndPoint {
    
    func fetchMovieDescription(id: Int, completion: @escaping( _ result: resultMovieDescription) -> Void) {
        var movie: MovieDescription?
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
                        movie = descriptionMovie
                      completion(resultMovieDescription.sucess(movie: movie))
                    } catch {
                      if let data = data {
                          let str = String(data: data, encoding: .utf8)
                          print("Parse Error3", str as Any, error)
                      } else {
                          print("Parse Error3", error)
                      }
                    completion(resultMovieDescription.failure(error: Erro.parseError(error: "Erro no parse")))
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
    
}
