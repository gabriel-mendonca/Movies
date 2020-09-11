//
//  SerieTableViewCell.swift
//  Movies
//
//  Created by Gabriel Mendonça on 13/07/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation
import UIKit

class SerieTableViewCell: UITableViewCell,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    
    private let layout = UICollectionViewFlowLayout()
    var serieTableViewCellViewModel: SerieTableViewCellViewModel = SerieTableViewCellViewModel()
    weak var delegate: SerieCollectionViewCellDelegate?
    
    func cellConfigurate(name: String) {
        label.text = name
        
        label.translatesAutoresizingMaskIntoConstraints = false
        let top = label.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10)
        let leading = label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        NSLayoutConstraint.activate([top,leading])
        contentView.addSubview(label)
        
    }
    
    func setupSerieCollectionViewContraints() {
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        let top = collectionView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10)
        let leading = collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        let trailing = collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        let bottom = collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        NSLayoutConstraint.activate([top,leading,trailing,bottom])
        contentView.addSubview(collectionView)
    }
    
    func setupSerieCollectionView() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SerieCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        serieTableViewCellViewModel.setupSerieTableViewCell {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
        
        
    }
    
    lazy var label: UILabel = {
        var textLabel = UILabel()
        textLabel.textColor = .white
        addSubview(textLabel)
        return textLabel
    }()
    
    lazy var collectionView: UICollectionView = {
        var collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        addSubview(collection)
        return collection
    }()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return serieTableViewCellViewModel.numberOfSerie()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SerieCollectionViewCell
        cell.image(url: serieTableViewCellViewModel.getSerie(at: indexPath.row))
        cell.setupSerieImageViewContraints()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = 125
        let width = 100
        return CGSize(width: width, height: height)
    }
    
    
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
               if delegate != nil {
                delegate?.cellTapped(serie: serieTableViewCellViewModel.genreSerie[indexPath.row])
               }
           }
    
    
}
