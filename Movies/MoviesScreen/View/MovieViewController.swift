//
//  ViewController.swift
//  Movies
//
//  Created by Gabriel Mendonça on 09/07/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController,UIScrollViewDelegate,MovieCollectionViewCellDelegate {
    
    var movieViewModel: MovieViewModel = MovieViewModel()
    var movieTableViewCellViewModel: MovieTableViewCellViewModel = MovieTableViewCellViewModel()
    private let layout = UICollectionViewFlowLayout()
    let screenHeight = UIScreen.main.bounds.height
    let scrollviewContentHeight = 4400 as CGFloat
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scroll.delegate = self
        setNeedsStatusBarAppearanceUpdate()
        setupContraints()
        movieTableViewCellViewModel.setupMoviePopular {
            self.collectionViewPopular.reloadData()
        }
        movieViewModel.setUpViewController {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        collectionViewPopular.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    lazy var label: UILabel = {
       var title = UILabel()
        title.textColor = .white
        title.text = "Popular"
        title.font = UIFont(name: "Kefa", size: 17.0)
        scroll.addSubview(title)
        return title
    }()
    
    lazy var scroll: UIScrollView = {
       var scrollView = UIScrollView()
        scrollView.contentSize = CGSize(width: view.frame.width, height: view.frame.height)
        scrollView.bounces = false
        view.addSubview(scrollView)
        return scrollView
    }()

    lazy var collectionViewPopular: UICollectionView = {
        var collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 10, left: 5, bottom: 5, right: 0)
        scroll.addSubview(collection)
        return collection
    }()
    
    lazy var tableView: UITableView = {
       var table = UITableView()
        table.isScrollEnabled = false
        table.bounces = false
        table.backgroundColor = .black
        scroll.addSubview(table)
        return table
    }()
    
    func cellTapped(movie: Movie) {
        let movieDescriptionViewModel = MovieDescriptionViewModel(id: movie.id ?? 0)
        let movieDescriptionViewController = MovieDescriptionViewController(movieDescriptionViewModel: movieDescriptionViewModel)
         present(movieDescriptionViewController, animated: true, completion: nil)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
   
        let yOffset = scroll.contentOffset.y
        
        if scroll == self.scroll {
            if yOffset >= scrollviewContentHeight - screenHeight {
                scroll.isScrollEnabled = false
                tableView.isScrollEnabled = true
                self.tableView.reloadData()
            }
        }
        
        if scroll == self.tableView {
            if yOffset <= 0 {
                self.scroll.isScrollEnabled = true
                self.tableView.isScrollEnabled = false
                self.tableView.reloadData()
            }
        }
    }
    
    func setupContraints() {
        
        scroll.translatesAutoresizingMaskIntoConstraints = false
        let topScroll = scroll.topAnchor.constraint(equalTo: view.topAnchor)
        let leadingScroll = scroll.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let trailingScroll = scroll.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let bottomScroll = scroll.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        let heightScroll = scroll.heightAnchor.constraint(equalToConstant: 1200.0)
        NSLayoutConstraint.activate([topScroll,leadingScroll,trailingScroll,bottomScroll,heightScroll])
        view.addSubview(scroll)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        let toplabel = label.topAnchor.constraint(equalTo: scroll.topAnchor,constant: 10)
        let leadinglabel = label.leadingAnchor.constraint(equalTo: scroll.leadingAnchor,constant: 10)
        NSLayoutConstraint.activate([toplabel,leadinglabel])
        scroll.addSubview(label)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let top = tableView.topAnchor.constraint(equalTo: collectionViewPopular.bottomAnchor,constant: 5)
        let bottom = tableView.bottomAnchor.constraint(equalTo: scroll.bottomAnchor)
        let trailing = tableView.trailingAnchor.constraint(equalTo: scroll.trailingAnchor)
        let leading = tableView.leadingAnchor.constraint(equalTo: scroll.leadingAnchor)
        let heightTable = tableView.heightAnchor.constraint(equalToConstant: 3900.0)
        let widthTable = tableView.widthAnchor.constraint(equalToConstant: view.frame.width)
        NSLayoutConstraint.activate([top,bottom,trailing,leading,heightTable,widthTable])
        scroll.addSubview(tableView)
        
        collectionViewPopular.translatesAutoresizingMaskIntoConstraints = false
        let topCollection = collectionViewPopular.topAnchor.constraint(equalTo: label.bottomAnchor)
        let leadingCollection = collectionViewPopular.leadingAnchor.constraint(equalTo: scroll.leadingAnchor)
        let trailingCollection = collectionViewPopular.trailingAnchor.constraint(equalTo: scroll.trailingAnchor)
        let height = collectionViewPopular.heightAnchor.constraint(equalToConstant: 285)
        let widhtCollection = collectionViewPopular.widthAnchor.constraint(equalToConstant: view.frame.width)
        NSLayoutConstraint.activate([topCollection,leadingCollection,trailingCollection,height,widhtCollection])
        scroll.addSubview(collectionViewPopular)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "cell")
        
        collectionViewPopular.delegate = self
        collectionViewPopular.dataSource = self
        collectionViewPopular.register(MoviePopularCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
}
extension MovieViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return movieViewModel.numberOfMoviesGenre()
     }
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MovieTableViewCell
        cell.cellConfigurate(name: movieViewModel.getMovie(at: indexPath.row).0)
        cell.movieTableViewCellViewModel.id = movieViewModel.getMovie(at: indexPath.row).1
        cell.setupCollectionView()
        cell.delegate = self
        cell.reloadData()
        cell.Mylabel.textColor = .white
        cell.backgroundColor = .black
        return cell
     }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 200
    }
  
}

extension MovieViewController: UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieTableViewCellViewModel.numberOfMovies()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MoviePopularCollectionViewCell
        cell.cornerRadiusPoster1()
        cell.imagem(url: movieTableViewCellViewModel.get(at: indexPath.row))
        cell.setupContraints()
        cell.contentView.backgroundColor = .clear
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let height = 278
        let widht = 187
        return CGSize(width: widht, height: height)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieDescriptionViewModel = MovieDescriptionViewModel(id: movieTableViewCellViewModel.listGenreMovie[indexPath.row].id ?? 0)
        let movieDescriptionViewController = MovieDescriptionViewController(movieDescriptionViewModel: movieDescriptionViewModel)
         present(movieDescriptionViewController, animated: true, completion: nil)
    }

    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let title = UILabel()
        title.textColor = .white
        
        return title
        
        
    }
    
    
}
