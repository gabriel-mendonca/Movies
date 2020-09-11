//
//  MoviePopularCollectionViewCell.swift
//  Movies
//
//  Created by Gabriel Mendonça on 06/08/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation
import UIKit

class MoviePopularCollectionViewCell: UICollectionViewCell {
    
    weak var delegate: MoviePopularCollectionViewDelegate?

    lazy var poster: UIImageView = {
       var image = UIImageView()
        contentView.addSubview(image)
        return image
    }()

    func setupContraints() {
        
        poster.translatesAutoresizingMaskIntoConstraints = false
        let topPoster = poster.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 5)
        let leadingPoster = poster.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        let trailingPoster = poster.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        let bottom = poster.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        NSLayoutConstraint.activate([topPoster,leadingPoster,trailingPoster,bottom])
        contentView.addSubview(poster)
    }
    
    func cornerRadiusPoster1() {
        poster.clipsToBounds = true
        poster.layer.cornerRadius = poster.frame.size.width/12.5
    }
    
    func imagem(url: URL?) {
        if let url = url {
            poster.sd_setImage(with: url) { (image, error, _, url) in
                
            }
        }
    }
}

protocol MoviePopularCollectionViewDelegate: NSObject {
    func cellTappedPopular(popular: Movie)
}
