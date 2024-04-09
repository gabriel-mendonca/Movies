//
//  MovieRecommendationCollectionViewCell.swift
//  Movies
//
//  Created by Gabriel Mendonça Sousa Gonçalves  on 01/02/21.
//  Copyright © 2021 Gabriel Mendonça. All rights reserved.
//

import UIKit

class MovieRecommendationCollectionViewCell: UICollectionViewCell {    
    
    lazy var poster: UIImageView = {
       var image = UIImageView()
        addSubview(image)
        return image
    }()
    
    lazy var progressLoad: UIActivityIndicatorView = {
        var progress = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        progress.startAnimating()
        progress.color = .black
        contentView.addSubview(progress)
        return progress
    }()
    
    func setImage(movieRecommendation: Movie) {
        poster.renderImageView(urlImage: movieRecommendation.posterURL ?? "")
        self.progressLoad.startAnimating()
        self.cornerRadiusPoster()
    }
    
    func setupContraints() {
        progressLoad.translatesAutoresizingMaskIntoConstraints = false
        let centerX = progressLoad.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        let centerY = progressLoad.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        NSLayoutConstraint.activate([centerX,centerY])
        contentView.addSubview(progressLoad)
        
        poster.translatesAutoresizingMaskIntoConstraints = false
        let top = poster.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 5)
        let leading = poster.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 5)
        let trailing = poster.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -5)
        let bottom = poster.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -5)
        NSLayoutConstraint.activate([top,leading,trailing, bottom])
        contentView.addSubview(poster)
    }
    
    func cornerRadiusPoster() {
        poster.clipsToBounds = true
        poster.layer.cornerRadius = poster.frame.size.width / 12.5
    }
    
}
