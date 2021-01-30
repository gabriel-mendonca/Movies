//
//  MovieHeaderViewPopular.swift
//  Movies
//
//  Created by Gabriel Mendonça Sousa Gonçalves  on 25/01/21.
//  Copyright © 2021 Gabriel Mendonça. All rights reserved.
//

import UIKit

class MoviePopularHeaderView: UIView,UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    private let layout = UICollectionViewFlowLayout()
    weak var delegate: MovieCollectionViewCellDelegate?
    var movieTableViewCellViewModel: MovieTableViewCellViewModel = MovieTableViewCellViewModel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        collectionViewPopular.reloadData()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var label: UILabel = {
       var title = UILabel()
        title.textColor = .white
        title.text = "Popular"
        title.font = UIFont(name: "Kefa", size: 17.0)
        self.addSubview(title)
        return title
    }()
    
    lazy var collectionViewPopular: UICollectionView = {
        var collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 5, right: 0)
        self.addSubview(collection)
        return collection
    }()
    
    
    func setup() {
        
        label.translatesAutoresizingMaskIntoConstraints = false
        let toplabel = label.topAnchor.constraint(equalTo: self.topAnchor,constant: -15)
        let leadinglabel = label.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10)
        NSLayoutConstraint.activate([toplabel,leadinglabel])
        self.addSubview(label)
        
        collectionViewPopular.translatesAutoresizingMaskIntoConstraints = false
        let topCollection = collectionViewPopular.topAnchor.constraint(equalTo: label.bottomAnchor)
        let leadingCollection = collectionViewPopular.leadingAnchor.constraint(equalTo:  self.leadingAnchor)
        let trailingCollection = collectionViewPopular.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        let height = collectionViewPopular.heightAnchor.constraint(equalToConstant: 285)//285
        let widhtCollection = collectionViewPopular.widthAnchor.constraint(equalToConstant: self.frame.width)
        let bottomCollection = collectionViewPopular.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        NSLayoutConstraint.activate([topCollection,leadingCollection,trailingCollection,height,widhtCollection, bottomCollection])
        self.addSubview(collectionViewPopular)
        
        setupCollectionView()
    }
    
    func setupCollectionView() {
        
        collectionViewPopular.delegate = self
        collectionViewPopular.dataSource = self
        collectionViewPopular.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        movieTableViewCellViewModel.setupMoviePopular {
            DispatchQueue.main.async {
            self.collectionViewPopular.reloadData()
            }
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieTableViewCellViewModel.numberOfMovies()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MovieCollectionViewCell
        cell.cornerRadiusPoster()
        cell.image(url: movieTableViewCellViewModel.get(at: indexPath.row))
        cell.setupPosterImageView()
        cell.contentView.backgroundColor = .clear
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = 278
        let widht = 187
        return CGSize(width: widht, height: height)
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if delegate != nil {
            delegate?.cellTapped(movie: movieTableViewCellViewModel.listGenreMovie[indexPath.row])
        }
    }
}
