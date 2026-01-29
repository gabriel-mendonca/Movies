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

final class NetworkServiceSeries {
    func fetchNameGenreSeries(
        completion: @escaping (ResultNameGenreSeries) -> Void
    ) {

        let queryItems = [
            URLQueryItem(name: "language", value: "pt-BR")
        ]

        guard let request = ApiClient.makeRequest(
            path: "/genre/tv/list",
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
                    let list = try JSONDecoder().decode(SerieGenreList.self, from: data)
                    completion(.sucess(serieList: list.genres))
                } catch {
                    completion(.failure(error: .parseError(error: "Erro no parse")))
                }
            }
        }.resume()
    }


    func fetchGenreSeries(
        id: Int,
        completion: @escaping (ResultGenreSerie) -> Void
    ) {

        let queryItems = [
            URLQueryItem(name: "language", value: "pt-BR"),
            URLQueryItem(name: "sort_by", value: "popularity.desc"),
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "with_genres", value: "\(id)"),
            URLQueryItem(name: "include_null_first_air_dates", value: "false")
        ]

        guard let request = ApiClient.makeRequest(
            path: "/discover/tv",
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
                    let list = try JSONDecoder().decode(ListSeries.self, from: data)
                    completion(.sucess(listGenre: list.results))
                } catch {
                    completion(.failure(error: .parseError(error: "Erro no parse")))
                }
            }
        }.resume()
    }

    
    func fetchSeriePopular(
        completion: @escaping (ResultGenreSerie) -> Void
    ) {

        let queryItems = [
            URLQueryItem(name: "language", value: "pt-BR"),
            URLQueryItem(name: "page", value: "1")
        ]

        guard let request = ApiClient.makeRequest(
            path: "/tv/popular",
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
                    let popular = try JSONDecoder().decode(ListSeries.self, from: data)
                    completion(.sucess(listGenre: popular.results))
                } catch {
                    completion(.failure(error: .parseError(error: "Erro no parse")))
                }
            }
        }.resume()
    }


}
