//
//  MovieTableViewCell.swift
//  Movies
//
//  Created by Gabriel Mendonça on 09/07/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation
import UIKit

class MovieTableViewCell: UITableViewCell,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    var movieTableViewCellViewModel: MovieTableViewCellViewModel = MovieTableViewCellViewModel()
    weak var delegate: MovieCollectionViewCellDelegate?
    let layout = UICollectionViewFlowLayout()
    
    func cellConfigurate(name: String) {
        Mylabel.text = name
        
        Mylabel.translatesAutoresizingMaskIntoConstraints = false
        let top = Mylabel.topAnchor.constraint(equalTo: contentView.topAnchor)
        let leading = Mylabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 10)
        NSLayoutConstraint.activate([top,leading])
        contentView.addSubview(Mylabel)
    }
    
    func setupCollectionView() {
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        let top = collectionView.topAnchor.constraint(equalTo: Mylabel.bottomAnchor,constant: 10)
        let leading = collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        let trailing = collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        let bottom = collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        NSLayoutConstraint.activate([top,leading,trailing,bottom])
        contentView.addSubview(collectionView)
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(MovieCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        movieTableViewCellViewModel.setupTableViewCell {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    lazy var Mylabel: UILabel = {
       var label = UILabel()
        contentView.addSubview(label)
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        var collection = UICollectionView(frame: .zero, collectionViewLayout: layout )
        layout.scrollDirection = .horizontal
        contentView.addSubview(collection)
        return collection
    }()
    
//    func numberOfSections(in collectionView: UICollectionView) -> Int {
//        return movieTableViewCellViewModel.numberOfMovies()
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieTableViewCellViewModel.numberOfMovies()
      }
      
      func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
          
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MovieCollectionViewCell
        cell.image(url: movieTableViewCellViewModel.get(at: indexPath.row))
        cell.setupPosterImageView()
        cell.contentView.backgroundColor = .clear
        return cell
      }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = 187
        let widht = 126
        return CGSize(width: widht, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if delegate != nil {
            delegate?.cellTapped(movie: movieTableViewCellViewModel.listGenreMovie[indexPath.row])
        }
    }
      
    func reloadData() {
        collectionView.reloadData()
    }
      
    
    
}
