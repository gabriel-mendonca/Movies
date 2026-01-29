//
//  SearchViewController.swift
//  Movies
//
//  Created by Gabriel Mendonça on 14/07/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController: UIViewController {
    
    // MARK: - Constants
    private enum Constants {
        static let cellIdentifier = "SearchCollectionViewCell"
        static let searchBarPlaceholder = "Digite o nome do filme"
        static let collectionViewInsets: CGFloat = 15
        static let cellHeight: CGFloat = 170
        static let topMargin: CGFloat = 10
    }
    
    // MARK: - Properties
    private let layout = UICollectionViewFlowLayout()
    var searchViewModel: SearchViewModel!
    var movieTableViewCellViewModel: MovieTableViewCellViewModel = MovieTableViewCellViewModel(coordinator: MovieCoordinator())
    
    // MARK: - Initialization
    init(viewModel: SearchViewModel) {
        self.searchViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .black
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Components
    lazy var searchBar: UISearchBar = {
        let search = UISearchBar()
        search.searchBarStyle = .minimal
        search.placeholder = Constants.searchBarPlaceholder
        search.sizeToFit()
        search.tintColor = .white
        search.backgroundColor = .black
        return search
    }()
    
    lazy var collectionViewSearch: UICollectionView = {
        layout.scrollDirection = .vertical
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collection.backgroundColor = .black
        return collection
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar(animated)
    }
    
    // MARK: - Setup Methods
    private func setupCollectionView() {
        collectionViewSearch.delegate = self
        collectionViewSearch.dataSource = self
        collectionViewSearch.register(
            SearchCollectionViewCell.self,
            forCellWithReuseIdentifier: Constants.cellIdentifier
        )
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = (view.frame.width / 3) - 20
        return CGSize(width: cellWidth, height: Constants.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        searchViewModel.goToMovieDescriptionOrSerieDescription(indexPath: indexPath.row)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchViewModel.searchQuery = searchBar.text ?? ""
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.searchTextField.textColor = .white
        handleSearchTextChange(searchText)
    }
    
    private func handleSearchTextChange(_ searchText: String) {
        if searchText.isEmpty {
            searchViewModel.searchQuery = searchText
            searchViewModel.searchMovie.removeAll()
            self.collectionViewSearch.reloadData()
        } else {
            searchViewModel.setupSearchTableView(query: searchText)
            self.collectionViewSearch.reloadData()
        }
    }
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchViewModel.numberOfSearch()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Constants.cellIdentifier,
            for: indexPath
        ) as? SearchCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        configureCell(cell, at: indexPath)
        return cell
    }
    
    private func configureCell(_ cell: SearchCollectionViewCell, at indexPath: IndexPath) {
        cell.setupView(url: searchViewModel.getSearch(at: indexPath.row))
    }
}

extension SearchViewController: ViewConfigurable {
    
    func setupHierarchy() {
        view.addSubview(searchBar)
        view.addSubview(collectionViewSearch)
    }
    
    func setupConstraints() {
        setupCollectionViewConstraints()
        setupSearchBarConstraints()
    }
    
    private func setupViews() {
        setupHierarchy()
        addToolbar(searchTextField: searchBar)
        hideKeyboardWhenTappedAround()
        setupCollectionView()
        searchBar.delegate = self
    }
    
    private func setupCollectionViewConstraints() {
        collectionViewSearch.makeConstraints { builder in
            builder
                .leading(to: view.leadingAnchor, constant: Constants.collectionViewInsets)
                .trailing(to: view.trailingAnchor, constant: -Constants.collectionViewInsets)
                .bottom(to: view.bottomAnchor)
        }
    }
    
    private func setupSearchBarConstraints() {
        searchBar.makeConstraints { builder in
            builder
                .top(to: view.safeAreaLayoutGuide.topAnchor, constant: Constants.topMargin)
                .leading(to: view.leadingAnchor)
                .trailing(to: view.trailingAnchor)
                .bottom(to: collectionViewSearch.topAnchor)
        }
    }
}
