//
//  SerieCollectionViewCell.swift
//  Movies
//
//  Created by Gabriel Mendonça on 13/07/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation
import UIKit

final class SerieCollectionViewCell: UICollectionViewCell {
    
    lazy var posterImageView: UIImageView = {
       var image = UIImageView()
        return image
    }()
    
    lazy var progressLoad: UIActivityIndicatorView = {
        var activity = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        activity.color = .white
        activity.startAnimating()
        return activity
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentView.subviews.forEach({ $0.removeFromSuperview() })
    }
    
    func setupView(url: String?) {
        image(url: url)
        contentView.addSubview(posterImageView)
        contentView.addSubview(progressLoad)
        setupSerieImageViewContraints()
        cornerRadiusPoster()
    }
    
    func setupSerieImageViewContraints() {
        
        posterImageView.translatesAutoresizingMaskIntoConstraints = false
        let top = posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor)
        let bottom = posterImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        let leading = posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        let trailing = posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        NSLayoutConstraint.activate([top,bottom,leading,trailing])
        
        progressLoad.translatesAutoresizingMaskIntoConstraints = false
        let centerX = progressLoad.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        let centerY = progressLoad.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        NSLayoutConstraint.activate([centerX,centerY])
    }
    
    private func image(url: String?) {
        posterImageView.renderImageView(urlImage: url ?? "")
        self.progressLoad.stopAnimating()
    }
    
    private func cornerRadiusPoster() {
        contentView.clipsToBounds = true
        guard contentView.frame.size.width > 0 else { return }
        contentView.layer.cornerRadius = contentView.frame.size.width / AppConstants.UI.posterCornerRadiusDivisor
    }
}
