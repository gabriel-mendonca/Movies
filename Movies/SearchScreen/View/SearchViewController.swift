//
//  SearchViewController.swift
//  Movies
//
//  Created by Gabriel Mendonça on 14/07/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation
import UIKit

class SearchViewController: UIViewController,UISearchBarDelegate,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource,SearchCollectionViewDelegate {
    
    private let layout = UICollectionViewFlowLayout()
    private var resultRequest: SearchMovieResult?
    weak var delegate: SearchCollectionViewDelegate?
    var searchViewModel: SearchViewModel = SearchViewModel()
    var serieViewModel: SerieTableViewCellViewModel = SerieTableViewCellViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addToolbar(searchTextField: searchBar)
        hideKeyboardWhenTappedAround()
        setupSearchBarContraints()
        setupCollectionViewContraints()
        setupCollectionView()
        searchBar.delegate = self
        
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
    
    func cellTapped(search: MovieSearch) {
        let movieDescriptionViewModel = MovieDescriptionViewModel(id: search.id ?? 0)
        let movieDescriptionViewController = MovieDescriptionViewController(movieDescriptionViewModel: movieDescriptionViewModel)
        present(movieDescriptionViewController, animated: true, completion: nil)
    }
    
    func cellTappedSerie(serie: Serie) {
        let serieDescriptionViewModel = SerieDescriptionViewModel(id: serie.id ?? 0)
        let serieDescriptionViewController = SerieDescriptionViewController(serieDescriptionViewModel: serieDescriptionViewModel)
        present(serieDescriptionViewController, animated: true, completion: nil)
    }
    
    func setupCollectionViewContraints() {
        
        collectionViewSearch.translatesAutoresizingMaskIntoConstraints = false
        let leading = collectionViewSearch.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 15)
        let trailing = collectionViewSearch.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -15)
        let bottom = collectionViewSearch.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        NSLayoutConstraint.activate([leading,trailing,bottom])
        view.addSubview(collectionViewSearch)
    }
    
    func setupCollectionView() {
        
        collectionViewSearch.delegate = self
        collectionViewSearch.dataSource = self
        collectionViewSearch.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
    }
    
    func setupSearchBarContraints() {
        
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        let top = searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,constant: 10)
        let leading = searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let trailing = searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let bottom = searchBar.bottomAnchor.constraint(equalTo: collectionViewSearch.topAnchor)
        NSLayoutConstraint.activate([top,leading,trailing,bottom])
        view.addSubview(searchBar)
        
        
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchViewModel.searchQuery = searchBar.text ?? ""
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchBar.searchTextField.textColor = .white
        if searchText.isEmpty {
            searchViewModel.searchQuery = searchText
            resultRequest?.results.removeAll()
            self.collectionViewSearch.reloadData()
//            self.collectionViewSearch.isHidden = true
        } else {
            searchViewModel.setupSearchTableView(query: searchText)
            self.collectionViewSearch.reloadData()
//            self.collectionViewSearch.isHidden = false
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchViewModel.searchMovie.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SearchCollectionViewCell
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

//        switch indexPath.row {
//        case indexPath.row:
//
//            let serieDescriptionViewModel = SerieDescriptionViewModel(id: searchViewModel.searchMovie[indexPath.row].id ?? 0)
//            let serieDescriptionViewController = SerieDescriptionViewController(serieDescriptionViewModel: serieDescriptionViewModel)
//            present(serieDescriptionViewController, animated: true, completion: nil)
//
//        case indexPath.row:
            let movieDescriptionViewModel = MovieDescriptionViewModel(id: searchViewModel.searchMovie[indexPath.row].id ?? 0)
            let movieDescriptionViewController = MovieDescriptionViewController(movieDescriptionViewModel: movieDescriptionViewModel)
            present(movieDescriptionViewController, animated: true, completion: nil)

//        default:
//            break
//        }
        
        
    }
}

extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func addToolbar(searchTextField: UISearchBar) {
        let toolbar = UIToolbar()
        toolbar.barStyle = UIBarStyle.default
        toolbar.isTranslucent = true
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(UIViewController.donePressed))
        toolbar.setItems([doneButton], animated: true)
        toolbar.isUserInteractionEnabled = true
        toolbar.sizeToFit()
        
        searchTextField.inputAccessoryView = toolbar
    }
    
    @objc func donePressed() {
        view.endEditing(true)
    }
    
}

