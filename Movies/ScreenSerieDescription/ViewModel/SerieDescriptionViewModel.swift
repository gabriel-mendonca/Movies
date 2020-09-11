//
//  SerieDescriptionViewModel.swift
//  Movies
//
//  Created by Gabriel Mendonça on 17/07/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation

class SerieDescriptionViewModel {

var id: Int?
let service = ServiceSerieDescription()
var serieDescription: SerieDescription?
var urlSerieDescriptionLink: URL?
var isFavorite: Bool = false
    
    init(id: Int) {
        self.id = id
    }

func fetchSerieDescription(sucess: @escaping( _ serieDescription: SerieDescription) -> Void, failure: @escaping() -> Void) {
    guard let id = id else {return}
    service.fetchSerieDescription(id: id) { (result) in
        switch result {
        case .sucess(let serie):
            if let description = serie {
                self.serieDescription = description
            sucess(description)
            }
        case .failure:
            self.handleError()
        }
    }
}
    func handleError() {}
    
    
    func setupHomePage() {
        guard let serie = serieDescription?.homepage else {return}
        guard let url = URL(string: serie) else {return}
        urlSerieDescriptionLink = url
    }
    
}
