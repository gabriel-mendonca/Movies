//
//  SearchService.swift
//  Movies
//
//  Created by Gabriel Mendonça on 14/07/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation

enum resultMovieSearch {
    case sucess(movieSearch: [MovieSearch])
    case failure(error: Erro )
}

class NetworkServiceSearch {
    
    func fetchMovieSearch(query: String, completion: @escaping( _ result: resultMovieSearch) -> Void) {
        var movieSearch = [MovieSearch]()
        
        guard let url = URL(string: serviceSearch(query: query) ) else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            DispatchQueue.main.async {
                if error == nil {
                    do{
                        guard let data = data else {return}

                        let movies = try JSONDecoder().decode(SearchMovieResult.self, from: data)
                        movieSearch = movies.results
                        completion(resultMovieSearch.sucess(movieSearch: movieSearch))
                    } catch {
                        if let data = data {
                            let str = String(data: data, encoding: .utf8)
                            print("Parse Error3",str as Any, error)
                        } else {
                            print("Parse Error3", error)
                        }
                        completion(resultMovieSearch.failure(error: Erro.parseError(error: "Erro no Parse")))
                    }
                }
            }
        }.resume()
    }

}

extension NetworkServiceSearch {
    
    func serviceSearch(query: String) -> String {
    
        let service = "https://api.themoviedb.org/3/search/movie?api_key=68206fe24af296b2560c51089250d615&language=pt-BR&query=\(query)&page=1&include_adult=false"
        
        return service
        
    }
    
    //"https://api.themoviedb.org/3/search/multi?api_key=68206fe24af296b2560c51089250d615&language=pt-BR&query=\(query)&page=1&include_adult=false"
    
}
