//
//  SerieCollectionViewCell.swift
//  Movies
//
//  Created by Gabriel Mendonça on 13/07/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation
import UIKit

class SerieCollectionViewCell: UICollectionViewCell {
    
    lazy var posterImageView: UIImageView = {
       var image = UIImageView()
        addSubview(image)
        return image
    }()
    
    lazy var progressLoad: UIActivityIndicatorView = {
        var activity = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        activity.color = .white
        activity.startAnimating()
        contentView.addSubview(activity)
        return activity
    }()
    
    func setupSerieImageViewContraints() {
        
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        let top = posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor)
        let bottom = posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        let leading = posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        let trailing = posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        NSLayoutConstraint.activate([top,bottom,leading,trailing])
        contentView.addSubview(posterImageView)
        
        progressLoad.translatesAutoresizingMaskIntoConstraints = false
        let centerX = progressLoad.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        let centerY = progressLoad.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        NSLayoutConstraint.activate([centerX,centerY])
        contentView.addSubview(progressLoad)
        
    }
    
    func image(url: URL?) {
        if let url = url {
            posterImageView.sd_setImage(with: url) { (image, error, _, url) in
                self.progressLoad.stopAnimating()
                self.cornerRadiusPoster()
            }
        } else {
            
        }
    }
    
    func cornerRadiusPoster() {
        posterImageView.clipsToBounds = true
        posterImageView.layer.cornerRadius = posterImageView.frame.size.width/12.5
    }
    
    override func prepareForReuse() {
        posterImageView.image = nil
    }
    
}

protocol SerieCollectionViewCellDelegate: AnyObject {
    func cellTapped(serie: Serie)
}
