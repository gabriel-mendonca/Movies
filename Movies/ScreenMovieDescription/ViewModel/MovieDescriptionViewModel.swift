//
//  DescriptionViewModel.swift
//  Movies
//
//  Created by Gabriel Mendonça on 16/07/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation
import AVFoundation
import AVKit

protocol MovieDescriptionViewModelDelegate: AnyObject {
    func cellTappedRecomendation(id: Int)
}

class MovieDescriptionViewModel {
    
    var service: DescriptionEndPoint = ServiceDescriptionMovie()
    var video = [MovieVideo]()
    var recommendation = [Movie]()
    var id: Int
    var urlMovieDescriptionLink: URL?
    var descriptionFirebase: MovieDescription?
    var isFavorite: Bool = false
    var childCoordinator: MovieDescriptionCoordinator
    weak var delegate: MovieDescriptionViewModelDelegate?
    
    init(id: Int, coordinator: MovieDescriptionCoordinator) {
        self.id = id
        self.childCoordinator = coordinator
        delegate = coordinator
    }
    
    func sendMovieRecommendation(id: Int) {
        delegate?.cellTappedRecomendation(id: id)
    }
    
    func fetchMovieDescription(sucess: @escaping( _ MovieDescription: MovieDescription) -> Void, failure: @escaping () -> Void) {
        service.fetchMovieDescription(id: id) { (result) in
            switch result {
            case .sucess(let movieDescription):
                if let description = movieDescription{
                    sucess(description)
                    self.descriptionFirebase = description
                    if let homePage = description.homepage {
                        self.setupHomePage(homePage: homePage)
                    }
                }
            case .failure:
                self.handleError()
            }
            failure()
        }
    }
    
    func fetchMovieVideo(sucess: @escaping(_ movieVideo: [MovieVideo]) -> Void) {
        service.fetchMovieVideo(id: id) { (result) in
            switch result {
            case .sucess(let movieVideo):
                let videoSucess = movieVideo
                self.video = videoSucess
                sucess(videoSucess)
            case .failure:
                self.handleError()
            }
        }
    }
    
    func fetchMovieRecommendation(sucess: @escaping(_ recommendation: [Movie]) -> Void) {
        service.fetchMovieRecommendations(id: id) { (result) in
            switch result {
            case .sucess(let movieRecommendation):
                let recommendationSucess = movieRecommendation
                self.recommendation = recommendationSucess
                sucess(recommendationSucess)
            case .failure:
                self.handleError()
            }
        }
    }

    
    private func handleError() {}
    
    func convertDateFormater(_ date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd"
        guard let newDate = dateFormatter.date(from: date) else {
            return date
        }
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter.string(from: newDate)
        
        
    }
    
    func setupHomePage(homePage: String) {
        guard let url = URL(string: homePage ) else { return }
        urlMovieDescriptionLink = url
    }
}

