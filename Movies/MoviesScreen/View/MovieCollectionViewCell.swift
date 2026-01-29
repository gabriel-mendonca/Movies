//
//  MovieCollectionViewCell.swift
//  Movies
//
//  Created by Gabriel Mendonça on 11/07/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation
import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Constants
    static let reuseIdentifier = "MovieCollectionViewCell"
    
    // MARK: - UI Components
    lazy var posterImageView: UIImageView = {
        let image = UIImageView()
        return image
    }()
    
    lazy var progressLoad: UIActivityIndicatorView = {
        let activity = UIActivityIndicatorView(style: .medium)
        activity.color = .white
        activity.startAnimating()
        return activity
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .black
        progressLoad.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentView.subviews.forEach({ $0.removeFromSuperview() })
    }

    // MARK: - Public Methods
    func setupPosterImageView() {
        setupViews()
        setupConstraints()
        applyCornerRadius()
    }
    
    func image(url: String?) {
        posterImageView.renderImageView(urlImage: url ?? "")
        progressLoad.stopAnimating()
    }
    
    func cornerRadiusPoster() {
        applyCornerRadius()
    }
    
    private func applyCornerRadius() {
        contentView.clipsToBounds = true
        guard contentView.frame.size.width > 0 else { return }
        contentView.layer.cornerRadius = contentView.frame.size.width / AppConstants.UI.posterCornerRadiusDivisor
    }
}

extension MovieCollectionViewCell:  ViewConfigurable {
    func setupConstraints() {
        setupPosterImageViewConstraints()
        setupProgressIndicatorConstraints()
    }
    
    func setupViews() {
        contentView.addSubview(posterImageView)
        contentView.addSubview(progressLoad)
    }
    
    private func setupPosterImageViewConstraints() {
        posterImageView.makeConstraints { builder in
            builder
                .top(to: contentView.topAnchor)
                .leading(to: contentView.leadingAnchor)
                .trailing(to: contentView.trailingAnchor)
                .bottom(to: contentView.bottomAnchor)
        }
    }
    
    private func setupProgressIndicatorConstraints() {
        progressLoad.makeConstraints { builder in
            builder
                .centerX(to: contentView.centerXAnchor)
                .centerY(to: contentView.centerYAnchor)
        }
    }
}
