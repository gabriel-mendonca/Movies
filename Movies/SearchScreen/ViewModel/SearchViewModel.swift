//
//  SearchViewModel.swift
//  Movies
//
//  Created by Gabriel Mendonça on 14/07/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation
import UIKit


protocol SearchViewModelDelegate: AnyObject {
    func sendToMovieOrSerie(indexPath: Int)
}

class SearchViewModel {
    var searchMovie = [MovieSearch]()
    var service = NetworkServiceSearch()
    var childCoordinator: SearchCoordinator
    weak var delegate: SearchViewModelDelegate?
    
    init(coordinator: SearchCoordinator, service: NetworkServiceSearch = NetworkServiceSearch()) {
        self.service = service
        self.childCoordinator = coordinator
        delegate = coordinator
        searchQuery = ""
    }
    
    func goToMovieDescriptionOrSerieDescription(indexPath: Int) {
        delegate?.sendToMovieOrSerie(indexPath: indexPath)
    }
    var searchQuery: String{
        didSet {
           reloadSearch()
        }
    }
    
    func reloadSearch() {
        if searchQuery.isEmpty {
            setupSearchTableView(query: searchQuery)
        }
    }
    
    func numberOfSearch() -> Int {
        return searchMovie.count
    }
    
    func getSearch(at row: Int) -> String? {
        return searchMovie[row].posterURL ?? ""
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
