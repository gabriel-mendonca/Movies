//
//  ViewController.swift
//  Movies
//
//  Created by Gabriel Mendonça on 09/07/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import UIKit

final class MovieViewController: UIViewController {
    
    // MARK: - Properties
    private var movieViewModel: MovieViewModel
    var movieTableViewCellViewModel: MovieTableViewCellViewModel!
    
    // MARK: - Initialization
    init(viewModel: MovieTableViewCellViewModel,
         movieViewModel: MovieViewModel = MovieViewModel()) {
        self.movieTableViewCellViewModel = viewModel
        self.movieViewModel = movieViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNeedsStatusBarAppearanceUpdate()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNavigationBar(animated)
        loadMovies()
    }
    
    // MARK: - Private Methods
    private func loadMovies() {
        movieViewModel.loadGenres(completion: { [weak self] in
            self?.tableView.reloadData()
        })
    }
    
    // MARK: - UI Components
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.bounces = false
        table.allowsSelection = false
        table.backgroundColor = .black
        view.addSubview(table)
        return table
    }()
    
    // MARK: - Setup Methods
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.reuseIdentifier)
        setupTableHeaderView()
    }
    
    private func setupTableHeaderView() {
        let headerView = MoviePopularHeaderView()
        headerView.delegate = self
        headerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 320)
        tableView.tableHeaderView = headerView
    }
}
// MARK: - UITableViewDataSource
extension MovieViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieViewModel.numberOfMoviesGenre()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MovieTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? MovieTableViewCell else {
            return UITableViewCell()
        }
        
        let (genreName, genreId) = movieViewModel.getMovie(at: indexPath.row)
        configureCell(cell, genreName: genreName, genreId: genreId)
        return cell
    }
    
    private func configureCell(_ cell: MovieTableViewCell, genreName: String, genreId: Int) {
        cell.cellConfigurate(name: genreName)
        cell.movieTableViewCellViewModel.id = genreId
        cell.setupCollectionView()
        cell.delegate = self
    }
}

// MARK: - UITableViewDelegate
extension MovieViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
}

extension MovieViewController: MovieCollectionViewCellDelegate {
    func cellTappedRecommendation(_ movie: Movie) {
        // Implementação vazia - delegado para MovieCoordinator
    }
    
    func cellTapped(movie: Movie) {
        movieTableViewCellViewModel.showMovieDescription(movie)
    }
}

extension MovieViewController: ViewConfigurable {
    func setupConstraints() {
        tableView.makeConstraints { builder in
            builder
                .top(to: view.topAnchor, constant: 5)
                .leading(to: view.leadingAnchor)
                .trailing(to: view.trailingAnchor)
                .bottom(to: view.bottomAnchor)
                .height(view.frame.height)
        }
        
        setupTableView()
    }
}
