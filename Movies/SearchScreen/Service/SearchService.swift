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

final class NetworkServiceSearch {
    
    func fetchMultiSearch(
        query: String,
        completion: @escaping (resultMovieSearch) -> Void
    ) {
        
        let queryItems = [
            URLQueryItem(name: "language", value: "pt-BR"),
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "page", value: "1"),
            URLQueryItem(name: "include_adult", value: "false")
        ]
        
        guard let request = ApiClient.makeRequest(
            path: "/search/multi",
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
                    let movies = try JSONDecoder().decode(SearchMovieResult.self, from: data)
                    completion(.sucess(movieSearch: movies.results))
                } catch {
                    completion(.failure(error: .parseError(error: error.localizedDescription)))
                }
            }
        }.resume()
    }
}
