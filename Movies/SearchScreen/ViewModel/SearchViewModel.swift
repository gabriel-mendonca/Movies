//
//  SearchViewModel.swift
//  Movies
//
//  Created by Gabriel Mendonça on 14/07/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation
import UIKit

class SearchViewModel {
    var searchMovie = [MovieSearch]()
    var searchSerie = [Serie]()
    var service = NetworkServiceSearch()
    
    init(service: NetworkServiceSearch = NetworkServiceSearch()) {
        self.service = service
        searchQuery = ""
    }
    
    var searchQuery: String{
        didSet {
           reloadSearch()
        }
    }
    
    func reloadSearch() {
        if searchQuery.isEmpty {
            setupSearchTableView(query: searchQuery)
        }else {
            
        }
    }
    
    func numberOfSearch() -> Int {
        return searchMovie.count
    }
    
    func getSearch(at row: Int) -> URL? {
        return searchMovie[row].posterURL ?? URL(string: "")
        
        
    }
    
    
    func setupSearchTableView(query: String) {
        service.fetchMultiSearch(query: query) { (result) in
            switch result {
            case .sucess(let movie):
                self.searchMovie = movie
            case .failure:
                self.handleError()
            }
        }
    }
    
    private func handleError() {
        
    }
    
}
