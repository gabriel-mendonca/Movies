//
//  SerieService.swift
//  Movies
//
//  Created by Gabriel Mendonça on 13/07/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation

enum ResultNameGenreSeries {
    case sucess(serieList: [SerieGenre])
    case failure(error: ErrorSerie)
}

enum ResultGenreSerie {
    case sucess(listGenre: [Serie])
    case failure(error: ErrorSerie)
}

enum ErrorSerie {
    case parseError(error: String)
}

class NetworkServiceSeries {
func fetchNameGenreSeries(completion: @escaping( _ result: ResultNameGenreSeries) -> Void) {
    var listGenre = [SerieGenre]()
    guard let url = URL(string: nameGenre()) else {
        return
    }
    URLSession.shared.dataTask(with: url) { (data, _, error) in
        if error == nil {
            do {
                
                guard let data = data else {
                    return
                }
                let list = try JSONDecoder().decode(SerieGenreList.self, from: data)
                listGenre = list.genres
                completion(ResultNameGenreSeries.sucess(serieList: listGenre))
            } catch  {
                if let data = data {
                    let str = String(data: data, encoding: .utf8)
                    print("Parse Error3", str as Any, error)
                } else {
                    print("Parse Error3", error)
                }
                completion(ResultNameGenreSeries.failure(error: ErrorSerie.parseError(error: "error no parse")))
            }
        }
    }.resume()
}

func fetchGenreSeries(id: Int, completion: @escaping( _ result: ResultGenreSerie) -> Void) {
    var serie = [Serie]()
    guard let url = URL(string: genreSerie(id: id)) else {
        return
    }
    URLSession.shared.dataTask(with: url) { (data, _, error) in
        if error == nil {
            do {
                
                guard let data = data else {
                    return
                }
                
                let list =  try JSONDecoder().decode(ListSeries.self, from: data)
                serie = list.results
                completion(ResultGenreSerie.sucess(listGenre: serie))
            } catch {
                if let data = data {
                    let str = String(data: data, encoding: .utf8)
                    print("Parse Error3",str as Any, error)
                } else {
                    print("Parse Error3", error)
                }
                completion(ResultGenreSerie.failure(error: ErrorSerie.parseError(error: "Erro no parse")))
                
            }
        }
    }.resume()
    
}
    
    func fetchSeriePoupular(completion: @escaping(_ result: ResultGenreSerie) -> Void) {
        var seriePopular = [Serie]()
        guard let url = URL(string: popularSerie()) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            DispatchQueue.main.async {
                if error == nil {
                    do {
                        guard let data = data else { return }
                        let popular = try JSONDecoder().decode(ListSeries.self, from: data)
                        seriePopular = popular.results
                        completion(ResultGenreSerie.sucess(listGenre: seriePopular))
                    } catch  {
                        if let data = data {
                            let str = String(data: data, encoding: .utf8)
                            print("Parse Error3", str as Any, error)
                        } else {
                            print("Parse Error3", error)
                        }
                        completion(ResultGenreSerie.failure(error: ErrorSerie.parseError(error: "Erro no parse")))
                    }
                }
            }
        }.resume()
    }

}

extension NetworkServiceSeries {
    
    func genreSerie(id: Int) -> String {
        let service = "https://api.themoviedb.org/3/discover/tv?api_key=68206fe24af296b2560c51089250d615&language=pt-BR&sort_by=popularity.desc&page=1&with_genres=\(id)&include_null_first_air_dates=false"
        
        return service
    }
    
    func nameGenre() -> String {
        let service = "https://api.themoviedb.org/3/genre/tv/list?api_key=68206fe24af296b2560c51089250d615&language=pt-BR"
        
        return service
    }
    
    func popularSerie() -> String {
        let servicePopular = "https://api.themoviedb.org/3/tv/popular?api_key=68206fe24af296b2560c51089250d615&language=pt-BR&page=1"
        
        return servicePopular
    }
    
}
