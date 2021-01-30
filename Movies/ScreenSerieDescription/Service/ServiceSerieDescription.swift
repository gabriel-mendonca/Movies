//
//  ServiceSerieDescription.swift
//  Movies
//
//  Created by Gabriel Mendonça on 17/07/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation

enum ResultSerieDescription {
    case sucess(serie: SerieDescription?)
    case failure(error: ErrorSerie)
}

class ServiceSerieDescription: SerieDescriptionEndPoint {
    
func fetchSerieDescription(id: Int, completion: @escaping(_ result: ResultSerieDescription) -> Void) {
    var serie: SerieDescription?
    guard let url = URL(string: serviceDescription(id: id)) else {
        return
    }
    URLSession.shared.dataTask(with: url) { (data, _, error) in
        DispatchQueue.main.async {
            if error == nil {
                do{
                    guard let data = data else {return}
                    
                    let descriptionSerie = try JSONDecoder().decode(SerieDescription.self, from: data)
                    serie = descriptionSerie
                    print(descriptionSerie)
                    completion(ResultSerieDescription.sucess(serie: serie))
                } catch {
                    if let data = data {
                        let str = String(data: data, encoding: .utf8)
                        print("Parse Error3", str as Any, error)
                    } else {
                        print("Parse Error3", error)
                    }
                    completion(ResultSerieDescription.failure(error: ErrorSerie.parseError(error: "erro no parse")))
                }
            }
        }
        
    }.resume()
}
}

extension ServiceSerieDescription {
    
    func serviceDescription(id: Int) -> String {
        let service = "https://api.themoviedb.org/3/tv/\(id)?api_key=68206fe24af296b2560c51089250d615&language=pt-BR"
        return service
    }
    
}
