//
//  MovieTableViewCelViewModel.swift
//  Movies
//
//  Created by Gabriel Mendonça on 09/07/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation

protocol MovieCollectionViewCellDelegate: AnyObject {
    func cellTapped(movie: Movie)
}

class MovieTableViewCellViewModel {
    
    var service: MovieEndPoint = TheMovieDb()
    var listGenreMovie = [Movie]()
    var id = 0
    
    func numberOfMovies() -> Int {
        return listGenreMovie.count
    }
    func get(at row: Int) -> URL? {
        return listGenreMovie[row].posterURL ?? URL(string: "")
    }
    
    func setupTableViewCell(completion: @escaping () -> Void) {
        service.fetchGenreMovie(id: id) { (result) in
            switch result {
            case .sucess(let movies):
                self.listGenreMovie = movies
                completion()
            case .failure:
                self.handleError()
            }
        }
    }
    
    func setupMoviePopular(completion: @escaping () -> Void){
        service.fetchMoviePopular { (result) in
            switch result {
            case.sucess(let popular):
                self.listGenreMovie = popular
                completion()
            case.failure:
                self.handleError()
            }
        }
    }
    
    func handleError() {
        
    }
    
}
