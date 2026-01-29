//
//  MovieTableViewCell.swift
//  Movies
//
//  Created by Gabriel Mendonça on 09/07/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation
import UIKit

class MovieTableViewCell: UITableViewCell {
    
    // MARK: - Constants
    static let reuseIdentifier = "MovieTableViewCell"
    
    // MARK: - Properties
    var movieTableViewCellViewModel: MovieTableViewCellViewModel = MovieTableViewCellViewModel(coordinator: MovieCoordinator())
    weak var delegate: MovieCollectionViewCellDelegate?
    private let layout = UICollectionViewFlowLayout()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        contentView.subviews.forEach({ $0.removeFromSuperview() })
    }
    
    // MARK: - UI Components
    lazy var Mylabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 5, right: 0)
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .black
        return collection
    }()
    
    // MARK: - Configuration
    func cellConfigurate(name: String) {
        Mylabel.text = name
    }
    
    func setupCollectionView() {
        setup()
        configureCollectionView()
        loadMovies()
    }
    
    private func configureCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(
            MovieCollectionViewCell.self,
            forCellWithReuseIdentifier: MovieCollectionViewCell.reuseIdentifier
        )
    }
    
    private func loadMovies() {
        movieTableViewCellViewModel.loadMovies { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
}

extension MovieTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieTableViewCellViewModel.numberOfMovies()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: MovieCollectionViewCell.reuseIdentifier,
            for: indexPath
        ) as? MovieCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let imageURL = movieTableViewCellViewModel.get(at: indexPath.row)
        cell.image(url: imageURL)
        cell.setupPosterImageView()
        cell.contentView.backgroundColor = .clear
        return cell
    }
}

extension MovieTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 126, height: 187)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let delegate = delegate else { return }
        let movie = movieTableViewCellViewModel.listGenreMovie[indexPath.row]
        delegate.cellTapped(movie: movie)
    }
}

extension MovieTableViewCell: ViewComposable {
    func setupConstraints() {
        collectionView.makeConstraints { builder in
            builder
                .top(to: Mylabel.bottomAnchor, constant: 10)
                .leading(to: contentView.leadingAnchor)
                .trailing(to: contentView.trailingAnchor)
                .bottom(to: contentView.bottomAnchor)
        }
        
        Mylabel.makeConstraints { builder in
            builder
                .top(to: contentView.topAnchor)
                .leading(to: contentView.leadingAnchor, constant: 10)
        }
    }
    
    func setupViews() {
        contentView.addSubview(Mylabel)
        contentView.addSubview(collectionView)
    }
}
