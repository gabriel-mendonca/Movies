//
//  DescriptionViewController.swift
//  Movies
//
//  Created by Gabriel Mendonça on 16/07/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import AVKit

class MovieDescriptionViewController: UIViewController {
    
    let movieDescriptionViewModel: MovieDescriptionViewModel
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupContraints()
        view.backgroundColor = .white
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        movieDescriptionViewModel.fetchMovieVideo {_ in
            self.removeButton()
        }
        movieDescriptionViewModel.fetchMovieDescription(sucess: { (movieDescription) in
            self.setup(description: movieDescription)
        }, failure: {})
    }
    
      init(movieDescriptionViewModel: MovieDescriptionViewModel) {
          self.movieDescriptionViewModel = movieDescriptionViewModel
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
    
    lazy var titleMovie: UILabel = {
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
        return imageAge
    }()
    
    lazy var tagline: UILabel = {
        var label = UILabel()
        label.textColor = .darkGray
        label.font = UIFont(name: "Kefa", size: 19.0)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        scrollView.addSubview(label)
        return label
    }()
    
    lazy var releaseDate: UILabel = {
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
    
    lazy var buttonVideo: UIButton = {
        var video = UIButton()
        video.setTitle("Trailer", for: .normal)
        video.backgroundColor = .black
        video.tintColor = .white
        video.addTarget(self, action: #selector(play), for: .touchUpInside)
        scrollView.addSubview(video)
        return video
    }()
    
    @objc func play() {
        YoutubeTrailer()
    }
    
    func YoutubeTrailer() {
        
        let count = movieDescriptionViewModel.video.count
        if count > 0 {
            for index in 0..<count {
                let controller = YoutuberViewController()
                controller.getVideo(code: movieDescriptionViewModel.video[index].key)
                present(controller, animated: true)
            }
        }
    }
    
    func removeButton() {

        buttonVideo.isHidden = movieDescriptionViewModel.video.count > 0 ? false : true
        
    }
    
    func setupContraints() {
        
        titleMovie.translatesAutoresizingMaskIntoConstraints = false
        let topTitle = titleMovie.topAnchor.constraint(equalTo: backdrop.bottomAnchor,constant: 28)
        let leadingTitle = titleMovie.leadingAnchor.constraint(equalTo: poster.trailingAnchor,constant: 8)
        let trailingTitle = titleMovie.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor,constant: -20)
        NSLayoutConstraint.activate([topTitle,leadingTitle,trailingTitle])
        scrollView.addSubview(titleMovie)
        
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
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        let topScroll = scrollView.topAnchor.constraint(equalTo: view.topAnchor)
        let leadingScroll = scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let trailingScroll = scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let bottom = scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        let heightScroll = scrollView.heightAnchor.constraint(equalToConstant: 1000.0)
        NSLayoutConstraint.activate([topScroll,leadingScroll,trailingScroll,bottom,heightScroll])
        view.addSubview(scrollView)
        
        evaluation.translatesAutoresizingMaskIntoConstraints = false
        let topEvaluation = evaluation.topAnchor.constraint(equalTo: titleMovie.bottomAnchor,constant: 10)
        let leadingEvaluation = evaluation.leadingAnchor.constraint(equalTo: poster.trailingAnchor,constant: 8)
        let width = evaluation.widthAnchor.constraint(equalToConstant: 94)
        NSLayoutConstraint.activate([topEvaluation,leadingEvaluation,width])
        scrollView.addSubview(evaluation)
        
        tagline.translatesAutoresizingMaskIntoConstraints = false
        let topTagline = tagline.topAnchor.constraint(equalTo: poster.bottomAnchor,constant: 20)
        let leadingTagline = tagline.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,constant: 20)
        let trailingTagline = tagline.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor,constant: -20)
        NSLayoutConstraint.activate([topTagline,leadingTagline,trailingTagline])
        scrollView.addSubview(tagline)
        
        releaseDate.translatesAutoresizingMaskIntoConstraints = false
        let topRelease = releaseDate.topAnchor.constraint(equalTo: tagline.bottomAnchor,constant: 20)
        let leadingRelease = releaseDate.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,constant: 20)
        let trailingRelease = releaseDate.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor,constant: -20)
        NSLayoutConstraint.activate([topRelease,leadingRelease,trailingRelease])
        scrollView.addSubview(releaseDate)
        
        synopse.translatesAutoresizingMaskIntoConstraints = false
        let topSynopse = synopse.topAnchor.constraint(equalTo: releaseDate.bottomAnchor,constant: 20)
        let leadingSynopse = synopse.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,constant: 20)
        let trailingSynopse = synopse.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor,constant: -20)
        NSLayoutConstraint.activate([topSynopse,leadingSynopse,trailingSynopse])
        scrollView.addSubview(synopse)
        
        buttonVideo.translatesAutoresizingMaskIntoConstraints = false
        let topVideo = buttonVideo.topAnchor.constraint(equalTo: synopse.bottomAnchor,constant: 20)
        let leadingVideo = buttonVideo.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,constant: 20)
        let trailingVideo = buttonVideo.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor,constant: -20)
        let bottomVideo = buttonVideo.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
        NSLayoutConstraint.activate([topVideo,leadingVideo,trailingVideo,bottomVideo])
        scrollView.addSubview(buttonVideo)
        
    }
    
    func setup(description: MovieDescription) {
        titleMovie.text = description.title ?? ""
        tagline.text = description.tagline ?? ""
        handleReleaseDate(dateRelease: description.releaseDate ?? "")
        guard let sinopse = description.overview else {return}
        synopse.text = "Sinopse: \n \(sinopse)"
        starEvaluation(nota: description.voteAverage)
        backdrop.sd_setImage(with: description.backdropURL)
        poster.sd_setImage(with: description.posterURL)
    }
    
    private func handleReleaseDate(dateRelease: String) {
        let fontSize: CGFloat = 20
        let text = NSMutableAttributedString(string: "Data de Lançamento: ", attributes: [.font: UIFont.systemFont(ofSize: fontSize, weight: .bold)])
        text.append(NSAttributedString(string: movieDescriptionViewModel.convertDateFormater(String(describing: dateRelease)), attributes: [.font: UIFont.systemFont(ofSize: fontSize, weight: .regular)]))
        releaseDate.attributedText = text
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
