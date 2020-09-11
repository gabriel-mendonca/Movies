//
//  MovieCollectionViewCell.swift
//  Movies
//
//  Created by Gabriel Mendonça on 11/07/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation
import UIKit
import SDWebImage

class MovieCollectionViewCell: UICollectionViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cornerRadiusPoster()
    }
    
    lazy var posterImageView: UIImageView = {
       var image = UIImageView()
        addSubview(image)
        return image
    }()
    
    lazy var prgressLoad: UIActivityIndicatorView = {
        var activity = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        activity.color = .white
        activity.startAnimating()
        contentView.addSubview(activity)
        return activity
    }()
    
    func setupPosterImageView() {
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        let top = posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor)
        let trailing = posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        let leading = posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        let bottom = posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        NSLayoutConstraint.activate([top,trailing,leading,bottom])
        contentView.addSubview(posterImageView)
        
        prgressLoad.translatesAutoresizingMaskIntoConstraints = false
        let centerX = prgressLoad.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        let centerY = prgressLoad.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        NSLayoutConstraint.activate([centerX,centerY])
        contentView.addSubview(prgressLoad)
        
    }
    override func prepareForReuse() {
        posterImageView.image = nil
    }
    
    func image(url: URL?) {
        if let url = url {
            posterImageView.sd_setImage(with: url) { (image, error, _, url) in
                self.prgressLoad.stopAnimating()
            }
        }
    }
    
    func cornerRadiusPoster() {
        posterImageView.clipsToBounds = true
        posterImageView.layer.cornerRadius = posterImageView.frame.size.width/12.5
    }
}

protocol MovieCollectionViewCellDelegate: AnyObject {
    func cellTapped(movie: Movie)
}
