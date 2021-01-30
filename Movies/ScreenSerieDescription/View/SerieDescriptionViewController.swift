//
//  SerieDescriptionViewController.swift
//  Movies
//
//  Created by Gabriel Mendonça on 17/07/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation
import UIKit

class SerieDescriptionViewController: UIViewController {
    
    let serieDescriptionViewModell: SerieDescriptionViewModel
    private let layout = UICollectionViewFlowLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCollection()
        setupContraints()
//        collectionViewSeasons.reloadData()
        view.backgroundColor = .white
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        serieDescriptionViewModell.fetchSerieDescription(sucess: { (serieDescription) in
            self.setup(serieDescription: serieDescription)
            self.collectionViewSeasons.reloadData()
        }, failure: {})
//        DispatchQueue.main.async {
//            self.collectionViewSeasons.reloadData()
//        }
    }
    
    init(serieDescriptionViewModel: SerieDescriptionViewModel) {
        serieDescriptionViewModell = serieDescriptionViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var scrollView: UIScrollView = {
        var scroll = UIScrollView()
        scroll.contentSize = CGSize(width: view.frame.width, height: view.frame.height)
        view.addSubview(scroll)
        return scroll
    }()
    
    lazy var backdrop: UIImageView = {
        var image = UIImageView()
        scrollView.addSubview(image)
        return image
    }()
    
    lazy var poster: UIImageView = {
        var posterImage = UIImageView()
        scrollView.addSubview(posterImage)
        return posterImage
    }()
    
    lazy var titleSerie: UILabel = {
        var label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont(name: "Kefa", size: 20.0)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        scrollView.addSubview(label)
        return label
    }()
    
    lazy var evaluation: UILabel = {
        var label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont(name: "System", size: 17.0)
        scrollView.addSubview(label)
        return label
    }()
    
    lazy var ageRange: UIImageView = {
        var imageAge = UIImageView()
        scrollView.addSubview(imageAge)
        return imageAge
    }()
    
    lazy var numberSeason: UILabel = {
        var label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont(name: "Kefa", size: 19.0)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        scrollView.addSubview(label)
        return label
    }()
    
    lazy var numberEpsodes: UILabel = {
        var label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont(name: "Kefa", size: 20.0)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        scrollView.addSubview(label)
        return label
    }()
    
    lazy var synopse: UILabel = {
        var label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont(name: "Kefa", size: 20.0)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        scrollView.addSubview(label)
        return label
    }()
    
    lazy var collectionViewSeasons: UICollectionView = {
        var collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collection.backgroundColor = .white
        scrollView.addSubview(collection)
        return collection
    }()
    
    func setupContraints() {
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        let topScroll = scrollView.topAnchor.constraint(equalTo: view.topAnchor)
        let leadingScroll = scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let trailingScroll = scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let bottom = scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        NSLayoutConstraint.activate([topScroll,leadingScroll,trailingScroll,bottom])
        view.addSubview(scrollView)
        
        titleSerie.translatesAutoresizingMaskIntoConstraints = false
        let topTitle = titleSerie.topAnchor.constraint(equalTo: backdrop.bottomAnchor,constant: 28)
        let leadingTitle = titleSerie.leadingAnchor.constraint(equalTo: poster.trailingAnchor,constant: 8)
        let trailingTitle = titleSerie.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor,constant: -20)
        NSLayoutConstraint.activate([topTitle,leadingTitle,trailingTitle])
        scrollView.addSubview(titleSerie)
        
        backdrop.translatesAutoresizingMaskIntoConstraints = false
        let top = backdrop.topAnchor.constraint(equalTo: scrollView.topAnchor)
        let leading = backdrop.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor)
        let trailing = backdrop.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        let height = backdrop.heightAnchor.constraint(equalToConstant: 200)
        let widht = backdrop.widthAnchor.constraint(equalToConstant: view.frame.width)
        NSLayoutConstraint.activate([top,leading,trailing,height,widht])
        scrollView.addSubview(backdrop)
        
        poster.translatesAutoresizingMaskIntoConstraints = false
        let topPoster = poster.topAnchor.constraint(equalTo: backdrop.bottomAnchor,constant: -20)
        let leadingPoster = poster.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20)
        let heightPoster = poster.heightAnchor.constraint(equalToConstant: 161)
        let widhtPoster = poster.widthAnchor.constraint(equalToConstant: 123)
        NSLayoutConstraint.activate([topPoster,leadingPoster,heightPoster,widhtPoster])
        scrollView.addSubview(poster)
        
        evaluation.translatesAutoresizingMaskIntoConstraints = false
        let topEvaluation = evaluation.topAnchor.constraint(equalTo: titleSerie.bottomAnchor,constant: 10)
        let leadingEvaluation = evaluation.leadingAnchor.constraint(equalTo: poster.trailingAnchor,constant: 8)
        let width = evaluation.widthAnchor.constraint(equalToConstant: 94)
        NSLayoutConstraint.activate([topEvaluation,leadingEvaluation,width])
        scrollView.addSubview(evaluation)
        
        numberSeason.translatesAutoresizingMaskIntoConstraints = false
        let topTagline = numberSeason.topAnchor.constraint(equalTo: poster.bottomAnchor,constant: 20)
        let leadingTagline = numberSeason.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,constant: 20)
        let trailingTagline = numberSeason.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor,constant: -20)
        NSLayoutConstraint.activate([topTagline,leadingTagline,trailingTagline])
        scrollView.addSubview(numberSeason)
        
        numberEpsodes.translatesAutoresizingMaskIntoConstraints = false
        let topRelease = numberEpsodes.topAnchor.constraint(equalTo: numberSeason.bottomAnchor,constant: 20)
        let leadingRelease = numberEpsodes.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,constant: 20)
        let trailingRelease = numberEpsodes.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor,constant: -20)
        NSLayoutConstraint.activate([topRelease,leadingRelease,trailingRelease])
        scrollView.addSubview(numberEpsodes)
        
        synopse.translatesAutoresizingMaskIntoConstraints = false
        let topSynopse = synopse.topAnchor.constraint(equalTo: numberEpsodes.bottomAnchor,constant: 20)
        let leadingSynopse = synopse.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,constant: 20)
        let trailingSynopse = synopse.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor,constant: -20)
        NSLayoutConstraint.activate([topSynopse,leadingSynopse,trailingSynopse])
        scrollView.addSubview(synopse)
        
        collectionViewSeasons.translatesAutoresizingMaskIntoConstraints = false
        let topCollection = collectionViewSeasons.topAnchor.constraint(equalTo: synopse.bottomAnchor,constant: 20)
        let leadingCollection = collectionViewSeasons.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor)
        let trailingCollection = collectionViewSeasons.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        let bottomCollection = collectionViewSeasons.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor,constant: -20)
        let heightCollection = collectionViewSeasons.heightAnchor.constraint(equalToConstant: 165)
        NSLayoutConstraint.activate([topCollection,leadingCollection,trailingCollection,bottomCollection,heightCollection])
        scrollView.addSubview(collectionViewSeasons)
        
    }
    
    func setupCollection() {
        
        collectionViewSeasons.delegate = self
        collectionViewSeasons.dataSource = self
//        collectionViewSeasons.reloadData()
        collectionViewSeasons.register(SerieDescriptionCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
    }
    
    func setup(serieDescription: SerieDescription) {
        titleSerie.text = serieDescription.name ?? ""
        guard let seasons = serieDescription.numberSeasons else {return}
        numberSeason.text = "Temporadas: \(seasons)"
        guard let episodes = serieDescription.numberEpisodes else {return}
        numberEpsodes.text = "Episódios: \(episodes)"
        guard let sinopse = serieDescription.overview else {return}
        synopse.text = "Sinopse: \n Temporadas: \n \(sinopse)"
        starEvaluation(nota: serieDescription.voteAverage)
        backdrop.sd_setImage(with: serieDescription.backdropURL)
        poster.sd_setImage(with: serieDescription.posterURL)
    }
    
    func ageRange(parentalRating: Bool?) {
        if parentalRating == true {
            ageRange.image = UIImage(named: "proibido")
        } else {
            ageRange.image = UIImage(named: "livre")
        }
    }
    
    func starEvaluation(nota: Float?) {
        
        guard let nota = nota else {
            return
        }
        let media = Int(nota/2)
        if media <= 1 {
            evaluation.text = "★☆☆☆☆"
        } else if media <= 2 {
            evaluation.text = "★★☆☆☆"
        } else if media <= 3 {
            evaluation.text = "★★★☆☆"
        } else if media <= 4 {
            evaluation.text = "★★★★☆"
        } else if media <= 5 {
            evaluation.text = "★★★★★"
        } else {
            evaluation.text = "☆☆☆☆☆"
        }
        
    }
    
    
}
extension SerieDescriptionViewController: UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = serieDescriptionViewModell.serieDescription?.seasons else {return 0}
        return count.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SerieDescriptionCollectionViewCell else {
            return UICollectionViewCell() }
        cell.imageSeasons(serieDescription: serieDescriptionViewModell.serieDescription?.seasons?[indexPath.row])
        cell.setupContraints()
        cell.title.textColor = .black
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 121, height: 160)
    }
    
    
    
    
}
