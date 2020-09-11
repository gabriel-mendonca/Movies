//
//  MovieViewModel.swift
//  Movies
//
//  Created by Gabriel Mendonça on 09/07/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation

class MovieViewModel {
    
    var genreMovie = [Genre]()
    var service: MovieEndPoint = TheMovieDb()
    
    func numberOfMoviesGenre() -> Int{
        return genreMovie.count
    }

    func getMovie(at row: Int) -> (String, Int) {
        return (genreMovie[row].name, genreMovie[row].id)
    }
    
    func setUpViewController(completion : @escaping () -> Void) {
        service.fetchNameGenre { result in
            switch result {
            case.sucess(let listGenre):
                self.genreMovie = listGenre
                completion()
            case .failure:
                self.handleError()
            }
        }
        
    }
    
    func handleError() {}
    
    
}
