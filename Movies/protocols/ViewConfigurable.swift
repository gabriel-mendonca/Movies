//
//  ViewConfigurable.swift
//  Movies
//
//  Created by Gabriel Mendonça Sousa Gonçalves.
//  Copyright © 2021 Gabriel Mendonça. All rights reserved.
//

import UIKit

/// Protocolo para views que precisam configurar constraints
protocol ViewConfigurable {
    func setupConstraints()
}

/// Protocolo para views que precisam configurar subviews
protocol ViewSetupable {
    func setupViews()
}

/// Protocolo para views que precisam configurar tanto views quanto constraints
protocol ViewComposable: ViewSetupable, ViewConfigurable {
    func setup()
}

extension ViewComposable {
    func setup() {
        setupViews()
        setupConstraints()
    }
}

/// Protocolo base para ViewControllers que seguem MVVM
protocol BaseViewController: UIViewController {
    associatedtype ViewModelType
    var viewModel: ViewModelType { get set }
}

/// Protocolo para células de tabela configuráveis
protocol TableViewCellConfigurable {
    func configure(with data: Any)
}

/// Protocolo para células de collection configuráveis
protocol CollectionViewCellConfigurable {
    func configure(with data: Any)
}
