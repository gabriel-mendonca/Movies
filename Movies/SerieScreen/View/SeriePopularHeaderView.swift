//
//  SeriePopularHeaderView.swift
//  Movies
//
//  Created by Gabriel Mendonça Sousa Gonçalves  on 28/01/21.
//  Copyright © 2021 Gabriel Mendonça. All rights reserved.
//

import UIKit

class SeriePopularheaderView: UIView,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    private let layout = UICollectionViewFlowLayout()
    weak var delegate: SerieCollectionViewCellDelegate?
    var serieTableViewCellViewModel: SerieTableViewCellViewModel = SerieTableViewCellViewModel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        collectionViewSeriePopular.reloadData()
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
    
    lazy var collectionViewSeriePopular: UICollectionView = {
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
        
        collectionViewSeriePopular.translatesAutoresizingMaskIntoConstraints = false
        let topCollection = collectionViewSeriePopular.topAnchor.constraint(equalTo: label.bottomAnchor)
        let leadingCollection = collectionViewSeriePopular.leadingAnchor.constraint(equalTo:  self.leadingAnchor)
        let trailingCollection = collectionViewSeriePopular.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        let height = collectionViewSeriePopular.heightAnchor.constraint(equalToConstant: 285)//285
        let widhtCollection = collectionViewSeriePopular.widthAnchor.constraint(equalToConstant: self.frame.width)
        let bottomCollection = collectionViewSeriePopular.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        NSLayoutConstraint.activate([topCollection,leadingCollection,trailingCollection,height,widhtCollection, bottomCollection])
        self.addSubview(collectionViewSeriePopular)
        
        setupCollectionView()
    }
    
    func setupCollectionView() {
        
        collectionViewSeriePopular.delegate = self
        collectionViewSeriePopular.dataSource = self
        collectionViewSeriePopular.register(SerieCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        serieTableViewCellViewModel.setupSeriePopular{
            DispatchQueue.main.async {
            self.collectionViewSeriePopular.reloadData()
            }
        }
        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return serieTableViewCellViewModel.numberOfSerie()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SerieCollectionViewCell
        cell.cornerRadiusPoster()
        cell.image(url: serieTableViewCellViewModel.getSerie(at: indexPath.row))
        cell.setupSerieImageViewContraints()
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
            delegate?.cellTapped(serie: serieTableViewCellViewModel.genreSerie[indexPath.row])
        }
    }
    

}
