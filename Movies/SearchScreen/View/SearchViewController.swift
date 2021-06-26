//
//  SearchViewController.swift
//  Movies
//
//  Created by Gabriel Mendonça on 14/07/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController: UIViewController,UISearchBarDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource{
    
    
    private let layout = UICollectionViewFlowLayout()
    var searchViewModel: SearchViewModel!
    var movieTableViewCellViewModel: MovieTableViewCellViewModel = MovieTableViewCellViewModel(coordinator: MovieCoordinator())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addToolbar(searchTextField: searchBar)
        hideKeyboardWhenTappedAround()
        setupContraints()
        setupCollectionView()
        searchBar.delegate = self
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        hideNavigationBar(animated)
        super.viewWillAppear(animated)
    }
    
    init(viewModel: SearchViewModel) {
        self.searchViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var searchBar: UISearchBar = {
        var search = UISearchBar()
        search.searchBarStyle = .minimal
        search.placeholder = "Digite o nome do filme"
        search.sizeToFit()
        search.tintColor = .white
        view.addSubview(search)
        return search
    }()
    
    lazy var collectionViewSearch: UICollectionView = {
        var collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        layout.scrollDirection = .vertical
        view.addSubview(collection)
        return collection
    }()
    
    func setupContraints() {
        
        collectionViewSearch.translatesAutoresizingMaskIntoConstraints = false
        let leading = collectionViewSearch.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 15)
        let trailing = collectionViewSearch.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -15)
        let bottom = collectionViewSearch.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        NSLayoutConstraint.activate([leading,trailing,bottom])
        view.addSubview(collectionViewSearch)
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        let topSearch = searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 10)
        let leadingSearch = searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let trailingSearch = searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let bottomSearch = searchBar.bottomAnchor.constraint(equalTo: collectionViewSearch.topAnchor)
        NSLayoutConstraint.activate([topSearch,leadingSearch,trailingSearch,bottomSearch])
        view.addSubview(searchBar)
    }
    
    func setupCollectionView() {
        
        collectionViewSearch.delegate = self
        collectionViewSearch.dataSource = self
        collectionViewSearch.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
    }
    
    func reloadCollection() -> Bool {
            collectionViewSearch.reloadData()
        
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchViewModel.searchQuery = searchBar.text ?? ""
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        reloadCollection()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.searchTextField.textColor = .white
        if searchText.isEmpty {
            searchViewModel.searchQuery = searchText
            searchViewModel.searchMovie.removeAll()
            self.collectionViewSearch.reloadData()
        } else {
            searchViewModel.setupSearchTableView(query: searchText)
            self.collectionViewSearch.reloadData()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchViewModel.numberOfSearch()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SearchCollectionViewCell
        cell.cornerRadiusPoster()
        cell.image(url: searchViewModel.getSearch(at: indexPath.row))
        cell.setupImageViewConstraints()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width / 3)-20, height: 170)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        searchViewModel.goToMovieDescriptionOrSerieDescription(indexPath: indexPath.row)
        
//        if searchViewModel.searchMovie[indexPath.row].mediaType == "movie" {
//            let movieDescriptionViewModel = MovieDescriptionViewModel(id: self.searchViewModel.searchMovie[indexPath.row].id ?? 0, coordinator: MovieDescriptionCoordinator(id: 0))
//                let movieDescriptionViewController = MovieDescriptionViewController(movieDescriptionViewModel: movieDescriptionViewModel)
//            self.navigationController?.pushViewController(movieDescriptionViewController, animated: true)
//
//        } else if searchViewModel.searchMovie[indexPath.row].mediaType == "tv" {
//            let serieDescriptionViewModel = SerieDescriptionViewModel(id: self.searchViewModel.searchMovie[indexPath.row].id ?? 0 )
//            let serieDescriptionViewController = SerieDescriptionViewController(serieDescriptionViewModel: serieDescriptionViewModel)
////            self.present(serieDescriptionViewController, animated: true, completion: nil)
//            self.navigationController?.pushViewController(serieDescriptionViewController, animated: true)
//        }
    }
}

