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
    
    func fetchGenreMovie(id: Int, completion: @escaping (resultGenreMovie) -> Void) {

        let queryItems = [
            URLQueryItem(name: "language", value: "pt-BR"),
            URLQueryItem(name: "sort_by", value: "popularity.desc"),
            URLQueryItem(name: "include_adult", value: "false"),
            URLQueryItem(name: "include_video", value: "false"),
            URLQueryItem(name: "page", value: "\(id)")
        ]

        guard let request = ApiClient.makeRequest(
            path: "/discover/movie",
            queryItems: queryItems
        ) else { return }

        URLSession.shared.dataTask(with: request) { data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error: .parseError(error: error.localizedDescription)))
                    return
                }

                guard let data = data else { return }

                do {
                    let list = try JSONDecoder().decode(ListMovie.self, from: data)
                    completion(.sucess(movieList: list.results))
                } catch {
                    completion(.failure(error: .parseError(error: "Erro no Parse")))
                }
            }
        }.resume()
    }
    
    func fetchNameGenre(completion: @escaping (resultNameGenre) -> Void) {

        let queryItems = [
            URLQueryItem(name: "language", value: "pt-BR")
        ]

        guard let request = ApiClient.makeRequest(
            path: "/genre/movie/list",
            queryItems: queryItems
        ) else { return }

        URLSession.shared.dataTask(with: request) { data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error: .parseError(error: error.localizedDescription)))
                    return
                }

                guard let data = data else { return }

                do {
                    let list = try JSONDecoder().decode(GenreList.self, from: data)
                    completion(.sucess(listGenre: list.genres))
                } catch {
                    completion(.failure(error: .parseError(error: "Erro no Parse")))
                }
            }
        }.resume()
    }

    
    func fetchMoviePopular(completion: @escaping (resultMoviePopular) -> Void) {

        let queryItems = [
            URLQueryItem(name: "language", value: "pt-BR")
        ]

        guard let request = ApiClient.makeRequest(
            path: "/movie/popular",
            queryItems: queryItems
        ) else { return }

        URLSession.shared.dataTask(with: request) { data, _, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(error: .parseError(error: error.localizedDescription)))
                    return
                }

                guard let data = data else { return }

                do {
                    let list = try JSONDecoder().decode(ListMovie.self, from: data)
                    completion(.sucess(popular: list.results))
                } catch {
                    completion(.failure(error: .parseError(error: "Erro no Parse")))
                }
            }
        }.resume()
    }
    
}
