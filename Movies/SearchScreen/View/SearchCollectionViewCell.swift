//
//  SearchCollectionViewCell.swift
//  Movies
//
//  Created by Gabriel Mendonça on 14/07/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation
import UIKit

protocol SearchCollectionViewDelegate: AnyObject {
    func cellTapped(search: MovieSearch)
    func cellTappedSerie(serie: Serie)
}

final class SearchCollectionViewCell: UICollectionViewCell {
    
    lazy var poster: UIImageView = {
       var image = UIImageView()
        return image
    }()
    
    lazy var activity: UIActivityIndicatorView = {
        var activty = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        activty.startAnimating()
        activty.color = .white
        return activty
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentView.subviews.forEach({ $0.removeFromSuperview() })
    }
    
    func setupView(url: String?) {
        image(url: url)
        setupHierarchy()
        cornerRadiusPoster()
    }
    
    private func setupHierarchy() {
        contentView.addSubview(poster)
        contentView.addSubview(activity)
        
        setupImageViewConstraints()
    }
    
    private func setupImageViewConstraints() {
        
        poster.translatesAutoresizingMaskIntoConstraints = false
        let top = poster.topAnchor.constraint(equalTo: contentView.topAnchor)
        let leading = poster.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        let trailing = poster.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        let bottom = poster.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        NSLayoutConstraint.activate([top,leading,trailing,bottom])
        
        activity.translatesAutoresizingMaskIntoConstraints = false
        let centerX = activity.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        let centerY = activity.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        NSLayoutConstraint.activate([centerX,centerY])
        
    }
    
    private func image(url: String?) {
        poster.renderImageView(urlImage: url ?? "")
        self.activity.stopAnimating()
        self.cornerRadiusPoster()
    }
    
    private func cornerRadiusPoster() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = contentView.frame.size.width/AppConstants.UI.posterCornerRadiusDivisor
    }
}
