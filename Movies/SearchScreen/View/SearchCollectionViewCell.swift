//
//  SearchCollectionViewCell.swift
//  Movies
//
//  Created by Gabriel Mendonça on 14/07/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation
import UIKit

class SearchCollectionViewCell: UICollectionViewCell {
    
    lazy var poster: UIImageView = {
       var image = UIImageView()
        addSubview(image)
        return image
    }()
    
    lazy var activity: UIActivityIndicatorView = {
        var activty = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        activty.startAnimating()
        activty.color = .white
        contentView.addSubview(activty)
        return activty
    }()
    
    func setupImageViewConstraints() {
        
        poster.translatesAutoresizingMaskIntoConstraints = false
        let top = poster.topAnchor.constraint(equalTo: contentView.topAnchor)
        let leading = poster.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        let trailing = poster.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        let bottom = poster.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        NSLayoutConstraint.activate([top,leading,trailing,bottom])
        contentView.addSubview(poster)
        
        activity.translatesAutoresizingMaskIntoConstraints = false
        let centerX = activity.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        let centerY = activity.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        NSLayoutConstraint.activate([centerX,centerY])
        contentView.addSubview(activity)
        
    }
    
    func image(url: String?) {
        poster.renderImageView(urlImage: url ?? "")
        self.activity.stopAnimating()
        self.cornerRadiusPoster()
    }
    
    func cornerRadiusPoster() {
        poster.clipsToBounds = true
        poster.layer.cornerRadius = poster.frame.size.width/12.5
    }
    
    override func prepareForReuse() {
        poster.image = nil
    }
    
}

protocol SearchCollectionViewDelegate: AnyObject {
    func cellTapped(search: MovieSearch)
    func cellTappedSerie(serie: Serie)
}
