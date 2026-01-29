//
//  SerieTableViewCell.swift
//  Movies
//
//  Created by Gabriel Mendonça on 13/07/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation
import UIKit

final class SerieTableViewCell: UITableViewCell {
    
    private let layout = UICollectionViewFlowLayout()
    private var serieTableViewCellViewModel: SerieTableViewCellViewModel!
    weak var delegate: SerieCollectionViewCellDelegate?
    
    lazy var titleLabel: UILabel = {
        var textLabel = UILabel()
        textLabel.textColor = .white
        return textLabel
    }()
    
    lazy var collectionView: UICollectionView = {
        var collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collection.backgroundColor = .black
        return collection
    }()
    
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
    
    private func cellConfigurate(name: String) {
        titleLabel.text = name
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        let top = titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 10)
        let leading = titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        NSLayoutConstraint.activate([top,leading])
        
    }
    
    func setupView(serieTableViewCellViewModel: SerieTableViewCellViewModel, nameTitle: String, delegate: SerieCollectionViewCellDelegate?) {
        self.serieTableViewCellViewModel = serieTableViewCellViewModel
        self.delegate = delegate
        setupHierarchy()
        setupSerieCollectionView()
        cellConfigurate(name: nameTitle)
    }
    
    private func setupHierarchy() {
        contentView.addSubview(titleLabel)
        contentView.addSubview(collectionView)
        
        setupSerieCollectionViewContraints()
    }
    
    private func setupSerieCollectionViewContraints() {
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        let top = collectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10)
        let leading = collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        let trailing = collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        let bottom = collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        NSLayoutConstraint.activate([top,leading,trailing,bottom])
        
    }
    
    private func setupSerieCollectionView() {
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SerieCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        serieTableViewCellViewModel.setupSerieTableViewCell { [weak self] in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
}

extension SerieTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = 187
        let width = 126
        return CGSize(width: width, height: height)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.cellTapped(serieTableViewCellViewModel.genreSerie[indexPath.row])
    }
}

extension SerieTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return serieTableViewCellViewModel.numberOfSerie()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SerieCollectionViewCell
        cell.setupView(url: serieTableViewCellViewModel.getSerie(at: indexPath.row))
        return cell
    }
}
