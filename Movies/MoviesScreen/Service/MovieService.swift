//
//  MovieService.swift
//  Movies
//
//  Created by Gabriel Mendonça on 09/07/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation


enum resultGenreMovie {
    case sucess(movieList: [Movie])
    case failure(error: Erro)
}

enum resultMoviePopular {
    case sucess(popular: [Movie])
    case failure(error: Erro)
}

enum resultNameGenre {
    case sucess(listGenre: [Genre])
    case failure(error: Erro)
}

enum Erro {
    case parseError(error: String)
}

class TheMovieDb: MovieEndPoint {
    
    func fetchGenreMovie(id: Int, completion: @escaping ( _ result: resultGenreMovie) -> Void) {
        var movie = [Movie]()
        guard let url = URL(string: serviceGenreMovie(id: id))
                   else {
                       return
               }
               URLSession.shared.dataTask(with: url) { (data, _, error) in
                   DispatchQueue.main.async {
                       if error == nil {
                           do {
                               
                               guard let data = data else {
                                   return
                               }
                               
                               let list =  try JSONDecoder().decode(ListMovie.self, from: data)
                            print(list)
                               movie = list.results
                            completion(resultGenreMovie.sucess(movieList: movie))
                           } catch  {
                               if let data = data {
                                   let str = String(bytes: data, encoding: .utf8)
                                   print("Parse Error3", str as Any, error)
                               } else {
                                   print("Parse Error3", error)
                               }
                               completion(resultGenreMovie.failure(error: Erro.parseError(error: "Erro no Parse")))
                           }
                       }
                   }
               }.resume()
    }
    
    func fetchNameGenre(completion: @escaping ( _ result: resultNameGenre) -> Void) {
        var listGenres = [Genre]()
        guard let url = URL(string: serviceNameGenre()) else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            DispatchQueue.main.async {
                if error == nil {
                    do {
                        
                        guard let data = data else {
                            return
                        }
                        
                        let list =  try JSONDecoder().decode(GenreList.self, from: data)
                        listGenres = list.genres
                        completion(resultNameGenre.sucess(listGenre: listGenres))
                    } catch  {
                        if let data = data {
                            let str = String(data: data, encoding: .utf8)
                            print("Parse Error3", str as Any, error)
                        } else {
                            print("Parse Error3", error)
                        }
                        completion(resultNameGenre.failure(error: Erro.parseError(error: "Erro no Parse")))
                    }
                }
            }
        }.resume()
    }
    
    func fetchMoviePopular(completion: @escaping (_ result: resultMoviePopular) -> Void) {
        var moviePopular = [Movie]()
        guard let url = URL(string: serviceMoviePopular())
                          else {
                              return
                      }
                      URLSession.shared.dataTask(with: url) { (data, _, error) in
                          DispatchQueue.main.async {
                              if error == nil {
                                  do {
                                      
                                      guard let data = data else {
                                          return
                                      }
                                      
                                      let list =  try JSONDecoder().decode(ListMovie.self, from: data)
                                   print(list)
                                      moviePopular = list.results
                                    completion(resultMoviePopular.sucess(popular: moviePopular))
                                  } catch  {
                                      if let data = data {
                                          let str = String(bytes: data, encoding: .utf8)
                                          print("Parse Error3", str as Any, error)
                                      } else {
                                          print("Parse Error3", error)
                                      }
                                      completion(resultMoviePopular.failure(error: Erro.parseError(error: "Erro no Parse")))
                                  }
                              }
                          }
                      }.resume()
    }
    
}

extension TheMovieDb {
    func serviceGenreMovie(id: Int) -> String {
        let service = "https://api.themoviedb.org/3/discover/movie?api_key=68206fe24af296b2560c51089250d615&language=pt-BR&sort_by=popularity.desc&include_adult=false&include_video=false&page=\(id)"
        
        return service
    }
    
    func serviceNameGenre() -> String {
        let service = "https://api.themoviedb.org/3/genre/movie/list?api_key=68206fe24af296b2560c51089250d615&language=pt-BR"
        
        return service
    }
    
    func serviceMoviePopular() -> String {
        let service = "https://api.themoviedb.org/3/movie/popular?api_key=68206fe24af296b2560c51089250d615&language=pt-BR"
        return service
    }
}
