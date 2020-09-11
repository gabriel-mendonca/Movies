//
//  SerieTableViewCellViewModel.swift
//  Movies
//
//  Created by Gabriel Mendonça on 13/07/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation

class SerieTableViewCellViewModel {
    
    var service = NetworkServiceSeries()
    var id = 0
    var genreSerie = [Serie]()
    
    func numberOfSerie() -> Int {
        return genreSerie.count
    }
    
    func getSerie(at row: Int) -> URL? {
        return genreSerie[row].posterURL
    }
    
    func setupSerieTableViewCell(completion: @escaping () -> Void) {
        service.fetchGenreSeries(id: id) { (result) in
            switch result {
            case .sucess(let listGenre):
                self.genreSerie = listGenre
                completion()
            case.failure:
                self.handleError()
            }
            completion()
        }
    }
    
    private func handleError() {
        
    }
    
}
