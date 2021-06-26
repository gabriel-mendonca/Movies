//
//  SerieCoordinator.swift
//  Movies
//
//  Created by Gabriel Mendonça Sousa Gonçalves  on 02/02/21.
//  Copyright © 2021 Gabriel Mendonça. All rights reserved.
//

import UIKit

class SerieCoordinator: Coordinator {
    var view: SerieViewController?
    var serieViewModel: SerieTableViewCellViewModel!
    var navigation: NavigationController?
    var serieDescriptionCoordinator: SerieDescriptionCoordinator?
    
    init() {
        serieViewModel = SerieTableViewCellViewModel(coordinator: self)
        view = SerieViewController(viewModel: serieViewModel)
        view?.serieTableViewCellViewModel = serieViewModel
        view?.serieTableViewCellViewModel?.delegate = self
    }
    
    func showSeries(_ model: Serie) {
        guard let navigation = navigation else { return }
        serieDescriptionCoordinator = SerieDescriptionCoordinator(id: model.id ?? 0)
        serieDescriptionCoordinator?.start(usingPresentation: .push(navigation: navigation))
        stop()
    }
    
    func stop() {
        view = nil
        serieViewModel = nil
    }
}

extension SerieCoordinator: SerieCollectionViewCellDelegate {
    func cellTapped(_ model: Serie) {
        showSeries(model)
    }
    
    
}
