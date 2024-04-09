//
//  SerieDescriptionCollectionViewCell.swift
//  Movies
//
//  Created by Gabriel Mendonça on 01/08/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation
import UIKit

class SerieDescriptionCollectionViewCell: UICollectionViewCell {
    
    lazy var imagem: UIImageView = {
       var image = UIImageView()
        addSubview(image)
        return image
    }()
    
    lazy var title: UILabel = {
        var label = UILabel()
        addSubview(label)
        return label
    }()
    
    lazy var progressLoad: UIActivityIndicatorView = {
        var activity = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        activity.startAnimating()
        contentView.addSubview(activity)
        return activity
    }()
    
    func imageSeasons(serieDescription: DescriptionSeason?) {
        imagem.renderImageView(urlImage: serieDescription?.posterURL ?? "")
        self.progressLoad.stopAnimating()
        title.text = serieDescription?.name
        
    }
    
    func setupContraints() {
        
        progressLoad.translatesAutoresizingMaskIntoConstraints = false
        let centerX = progressLoad.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        let centerY = progressLoad.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        NSLayoutConstraint.activate([centerX,centerY])
        contentView.addSubview(progressLoad)
        
        imagem.translatesAutoresizingMaskIntoConstraints = false
        let top = imagem.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 5)
        let leading = imagem.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 5)
        let trailing = imagem.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -5)
        NSLayoutConstraint.activate([top,leading,trailing])
        contentView.addSubview(imagem)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        let topTitle = title.topAnchor.constraint(equalTo: imagem.bottomAnchor,constant: 5)
        let leadingTitle = title.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 5)
        let trailingTitle = title.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -5)
        let bottom = title.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -5)
        NSLayoutConstraint.activate([topTitle,leadingTitle,trailingTitle,bottom])
        contentView.addSubview(title)
        

        
    }
    
    
}
