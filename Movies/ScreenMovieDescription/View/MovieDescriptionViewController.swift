//
//  DescriptionViewController.swift
//  Movies
//
//  Created by Gabriel Mendonça on 16/07/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation
import UIKit
import SafariServices

class MovieDescriptionViewController: UIViewController,UIViewControllerTransitioningDelegate, UINavigationControllerDelegate {
    
    let transition = TransitionNavigationController()
    
    var movieDescriptionViewModel: MovieDescriptionViewModel!
    var movieTableViewCellViewModel: MovieTableViewCellViewModel!
    private let layout = UICollectionViewFlowLayout()
    weak var delegate: MovieCollectionViewCellDelegate?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.safeAreaLayoutGuide.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        view.backgroundColor = UIColor(patternImage: UIImage(named: "backgroundOriginal")!)
        navigationController?.delegate = self
        
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.popStyle = operation == .pop
        return transition
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if Reachability.isConnectedToNetwork() {
        movieDescriptionViewModel.fetchMovieVideo {_ in
            self.removeButton()
        }
        movieDescriptionViewModel.fetchMovieDescription(sucess: { (movieDescription) in
            self.setup(description: movieDescription)
            self.removeButtonMore()
            self.setupContraints()
            self.setTitleRecommendation()
        }, failure: {})
        
        movieDescriptionViewModel.fetchMovieRecommendation { _ in
            self.setupCollection()
            self.collectionViewRecommendation.reloadData()
        }
        } else {
            callErrorView()
        }
    }
    
      init(movieDescriptionViewModel: MovieDescriptionViewModel) {
          self.movieDescriptionViewModel = movieDescriptionViewModel
          super.init(nibName: nil, bundle: nil)
      }

      required init?(coder: NSCoder) {
          fatalError("init(coder:) has not been implemented")
      }
    
    func callErrorView() {
        let errorView = ScreenError()
        errorView.setup(viewController: self)
        errorView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.height)
        view.addSubview(errorView)
    }
      
    
    lazy var scrollView: UIScrollView = {
       var scroll = UIScrollView()
        scroll.contentSize = CGSize(width: view.frame.width, height: view.frame.height)
        view.addSubview(scroll)
        return scroll
    }()
    
    lazy var viewMore: UIView = {
        var moreView = UIView()
        return moreView
    }()
    
    lazy var viewTrailer: UIView = {
        var trailerView = UIView()
        return trailerView
    }()
    
    lazy var stackView: UIStackView = {
       var stack = UIStackView(arrangedSubviews: [tagline,releaseDate,synopse,recommendationTitle])
        stack.alignment = .fill
        stack.spacing = 20
        stack.axis = .vertical
        stack.distribution = .equalSpacing
        scrollView.addSubview(stack)
        return stack
    }()
    
    lazy var stackViewButtons: UIStackView = {
       var stackButtons = UIStackView(arrangedSubviews: [viewTrailer,viewMore])
        stackButtons.heightAnchor.constraint(equalToConstant: 70).isActive = true
        stackButtons.axis = .horizontal
        stackButtons.distribution = .fillEqually
        stackButtons.alignment = .fill
        scrollView.addSubview(stackButtons)
        return stackButtons
    }()
    
    lazy var collectionViewRecommendation: UICollectionView = {
        var collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.heightAnchor.constraint(equalToConstant: 190).isActive = true
        collection.backgroundColor = .clear
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 5, right: 0)
        scrollView.addSubview(collection)
        return collection
    }()
    
    lazy var backdrop: UIImageView = {
       var image = UIImageView()
        scrollView.addSubview(image)
        return image
    }()
    
    lazy var backButton: UIButton = {
       var back = UIButton()
//        back.setImage(UIImage(named: "backButton"), for: .normal)
        back.setTitle("voltar", for: .normal)
        back.tintColor = UIColor.white
        back.addTarget(self, action: #selector(backPage), for: .touchUpInside)
        scrollView.addSubview(back)
        return back
    }()
    
    lazy var closeButton: UIButton = {
       var close = UIButton()
        close.setImage(UIImage(named: "closeButton"), for: .normal)
        close.addTarget(self, action: #selector(exitDetails), for: .touchUpInside)
        scrollView.addSubview(close)
        return close
    }()
    
    lazy var poster: UIImageView = {
       var posterImage = UIImageView()
        scrollView.addSubview(posterImage)
        return posterImage
    }()
    
    lazy var titleMovie: UILabel = {
        var label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Kefa", size: 20.0)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        scrollView.addSubview(label)
        return label
    }()
    
    lazy var evaluation: UILabel = {
        var label = UILabel()
        label.textColor = .white
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
        label.textColor = .white
        label.font = UIFont(name: "Kefa", size: 19.0)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    lazy var releaseDate: UILabel = {
        var label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Kefa", size: 20.0)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    lazy var synopse: UILabel = {
        var label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Kefa", size: 20.0)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    lazy var more: UIButton = {
       var button = UIButton()
        button.setImage(#imageLiteral(resourceName: "plus"), for: .normal)
        button.addTarget(self, action: #selector(actionMore), for: .touchUpInside)
        viewMore.addSubview(button)
        return button
    }()
    
    lazy var trailer: UIButton = {
        var video = UIButton()
        video.setImage(#imageLiteral(resourceName: "youtubeButton"), for: .normal)
        video.addTarget(self, action: #selector(play), for: .touchUpInside)
        viewTrailer.addSubview(video)
        return video
    }()
    
    lazy var recommendationTitle: UILabel = {
       var titleRecommendation = UILabel()
        titleRecommendation.textColor = .white
        titleRecommendation.font = UIFont(name: "Kefa", size: 19)
        titleRecommendation.font = .boldSystemFont(ofSize: 19)
        titleRecommendation.lineBreakMode = .byWordWrapping
        scrollView.addSubview(titleRecommendation)
        return titleRecommendation
    }()
    
    func setTitleRecommendation() {
        
        recommendationTitle.text = "Recomendações:"
//        movieDescriptionViewModel.fetchMovieDescription { (movieDescrition) in
            let fontSize: CGFloat = 19
            let text = NSMutableAttributedString(string: "Recomendação para: ", attributes: [.font: UIFont.systemFont(ofSize: fontSize, weight: .bold)])
//            text.append(NSAttributedString(string: movieDescrition.title ?? "untitle", attributes: [.font: UIFont.systemFont(ofSize: fontSize, weight: .regular)]))
//            self.recommendationTitle.attributedText = text
//        } failure: {}
    }
    
    @objc private func play() {
        youtubeTrailer()
    }
    
    func youtubeTrailer() {
        
        let count = movieDescriptionViewModel.video.count
        if count > 0 {
            for index in 0..<count {
                let controller = YoutuberViewController()
                controller.getVideo(code: movieDescriptionViewModel.video[index].key ?? "")
                present(controller, animated: true)
            }
        }
    }
    
    @objc private func actionMore() {
        guard let url = movieDescriptionViewModel.urlMovieDescriptionLink else {
            return
        }
        let safari = SFSafariViewController(url: url)
        present(safari, animated: true, completion: nil)
    }
    
     private func removeButton() {

        trailer.isHidden = movieDescriptionViewModel.video.count > 0 ? false : true
        
    }
    
    private func removeButtonMore() {
        
        movieDescriptionViewModel.fetchMovieDescription { (movieDescription) in
            self.more.isHidden = movieDescription.homepage == "" ? true : false
        } failure: {}
        
    }
    
    private func setupContraints() {
        
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
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        let topBack = backButton.topAnchor.constraint(equalTo: backdrop.topAnchor, constant: 10)
        let leadindBack = backButton.leadingAnchor.constraint(equalTo: backdrop.leadingAnchor,constant: 15)
        let heigthBack = backButton.heightAnchor.constraint(equalToConstant: 30)
        let widhtBack = backButton.widthAnchor.constraint(equalToConstant: 60)
        NSLayoutConstraint.activate([topBack,leadindBack,heigthBack,widhtBack])
        scrollView.addSubview(backButton)
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        let topButton = closeButton.topAnchor.constraint(equalTo: backdrop.topAnchor, constant: 10)
        let trailingButton = closeButton.trailingAnchor.constraint(equalTo: backdrop.trailingAnchor, constant: -15)
        let heightButton = closeButton.heightAnchor.constraint(equalToConstant: 30)
        let widhtButton = closeButton.widthAnchor.constraint(equalToConstant: 30)
        NSLayoutConstraint.activate([topButton, trailingButton,heightButton,widhtButton])
        scrollView.addSubview(closeButton)
        
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
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let topStack = stackView.topAnchor.constraint(equalTo: poster.bottomAnchor,constant: 20)
        let leadingStack = stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,constant: 20)
        let trailingStack = stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor,constant: -20)
        NSLayoutConstraint.activate([topStack,leadingStack,trailingStack])
        scrollView.addSubview(stackView)
        
        collectionViewRecommendation.translatesAutoresizingMaskIntoConstraints = false
        let topCollection = collectionViewRecommendation.topAnchor.constraint(equalTo: stackView.bottomAnchor,constant: 5)
        let leadingCollection = collectionViewRecommendation.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor)
        let trailingCollection = collectionViewRecommendation.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor)
        NSLayoutConstraint.activate([topCollection,leadingCollection,trailingCollection])
        scrollView.addSubview(collectionViewRecommendation)
        
        stackViewButtons.translatesAutoresizingMaskIntoConstraints = false
        let topStackButtons = stackViewButtons.topAnchor.constraint(equalTo: collectionViewRecommendation.bottomAnchor, constant: 20)
        let leadingStackButtons = stackViewButtons.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,constant: 20)
        let trailingStackButtons = stackViewButtons.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor,constant: -20)
        let bottomStackButtons = stackViewButtons.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
        NSLayoutConstraint.activate([topStackButtons,leadingStackButtons,trailingStackButtons,bottomStackButtons])
        scrollView.addSubview(stackViewButtons)
        
        more.translatesAutoresizingMaskIntoConstraints = false
        let topMore = more.topAnchor.constraint(equalTo: viewMore.topAnchor)
        let moreCenterX = more.centerXAnchor.constraint(equalTo: viewMore.centerXAnchor)
        let widhtMore = more.widthAnchor.constraint(equalToConstant: 70)
        let bottomMore = more.bottomAnchor.constraint(equalTo: viewMore.bottomAnchor)
        NSLayoutConstraint.activate([topMore,moreCenterX,widhtMore,bottomMore])
        viewMore.addSubview(more)

        trailer.translatesAutoresizingMaskIntoConstraints = false
        let topVideo = trailer.topAnchor.constraint(equalTo: viewTrailer.topAnchor)
        let videoCenterX = trailer.centerXAnchor.constraint(equalTo: viewTrailer.centerXAnchor)
        let widhtVideo = trailer.widthAnchor.constraint(equalToConstant: 70)
        let bottomVideo = trailer.bottomAnchor.constraint(equalTo: viewTrailer.bottomAnchor)
        NSLayoutConstraint.activate([topVideo,videoCenterX,widhtVideo,bottomVideo])
        viewTrailer.addSubview(trailer)
        
    }
    
    @objc func exitDetails() {
        self.dismiss(animated: true, completion: nil)
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func backPage() {
        self.dismiss(animated: true, completion: nil)
        navigationController?.popViewController(animated: true)
    }
    
    func animateView() {
        self.view.alpha = 0
        self.view.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        
        UIView.animate(
            withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.55, initialSpringVelocity: 3,
            options: .curveEaseOut, animations: {
                self.view.transform = .identity
                self.view.alpha = 1
        }, completion: nil)
    }
    
    
    func setupCollection() {
        collectionViewRecommendation.delegate = self
        collectionViewRecommendation.dataSource = self
        collectionViewRecommendation.register(MovieRecommendationCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    func setup(description: MovieDescription) {
        titleMovie.text = description.title ?? ""
        tagline.text = description.tagline ?? ""
        handleReleaseDate(dateRelease: description.releaseDate ?? "")
        guard let sinopse = description.overview else {return}
        synopse.text = "Sinopse: \n \(sinopse)"
        starEvaluation(nota: description.voteAverage)
        if description.backdropURL != nil {
            backdrop.renderImageView(urlImage: description.backdropURL ?? "")
        } else {
            backdrop.image = UIImage(named: "imagem indisponivel")
        }
        poster.renderImageView(urlImage: description.posterURL ?? "")
    }
    
    private func handleReleaseDate(dateRelease: String) {
        let fontSize: CGFloat = 20
        let text = NSMutableAttributedString(string: "Data de Lançamento: ", attributes: [.font: UIFont.systemFont(ofSize: fontSize, weight: .bold)])
        text.append(NSAttributedString(string: movieDescriptionViewModel.convertDateFormater(String(describing: dateRelease)), attributes: [.font: UIFont.systemFont(ofSize: fontSize, weight: .regular)]))
        releaseDate.attributedText = text
    }
    
    private func ageRange(parentalRating: Bool?) {
        if parentalRating == true {
            ageRange.image = UIImage(named: "proibido")
        } else {
            ageRange.image = UIImage(named: "livre")
        }
    }
    
    private func starEvaluation(nota: Float?) {
        
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

extension MovieDescriptionViewController: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieDescriptionViewModel.recommendation.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MovieRecommendationCollectionViewCell
        cell.setImage(movieRecommendation: movieDescriptionViewModel.recommendation[indexPath.row])
        cell.setupContraints()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let recommendation = movieDescriptionViewModel.recommendation[indexPath.row].id ?? 0
        movieDescriptionViewModel.sendMovieRecommendation(id: recommendation)
//        let movieDescriptionViewModel = MovieDescriptionViewModel(id: recommendation)
//        let movieDescriptionViewController = MovieDescriptionViewController(movieDescriptionViewModel: movieDescriptionViewModel)
//        navigationController?.pushViewController(movieDescriptionViewController, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 126, height: 187)
    }
    
}
