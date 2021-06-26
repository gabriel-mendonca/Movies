//
//  MovieDescriptionCoordinator.swift
//  Movies
//
//  Created by Gabriel Mendonça Sousa Gonçalves  on 02/02/21.
//  Copyright © 2021 Gabriel Mendonça. All rights reserved.
//

import UIKit

class SerieDescriptionCoordinator: Coordinator {
    var view: SerieDescriptionViewController?
    var navigation: NavigationController?
    var viewModel: SerieDescriptionViewModel!
    
    
    init(id: Int) {
        viewModel = SerieDescriptionViewModel(id: id)
        view = SerieDescriptionViewController(serieDescriptionViewModel: viewModel)
    }
    
    func stop() {
        view = nil
        navigation = nil
        viewModel = nil
    }
    
}
