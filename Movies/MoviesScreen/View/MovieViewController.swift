//
//  ViewController.swift
//  Movies
//
//  Created by Gabriel Mendonça on 09/07/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import UIKit

class MovieViewController: UIViewController,UIScrollViewDelegate,MovieCollectionViewCellDelegate {
    func cellTappedRecommendation(_ movie: Movie) {
    }
    
    
    var movieViewModel: MovieViewModel = MovieViewModel()
    var movieTableViewCellViewModel: MovieTableViewCellViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNeedsStatusBarAppearanceUpdate()
        setupContraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        hideNavigationBar(animated)
        movieViewModel.setUpViewController {
            self.tableView.reloadData()
        }
    }
    
    init(viewModel: MovieTableViewCellViewModel) {
        self.movieTableViewCellViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var tableView: UITableView = {
       var table = UITableView()
        table.bounces = false
        table.allowsSelection = false
        table.backgroundColor = .black
        view.addSubview(table)
        return table
    }()
    
    func cellTapped(movie: Movie) {
        movieTableViewCellViewModel.showMovieDescription(movie)
    }
    
    func setupContraints() {
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let top = tableView.topAnchor.constraint(equalTo: view.bottomAnchor,constant: 5)
        let bottom = tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        let trailing = tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let leading = tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let heightTable = tableView.heightAnchor.constraint(equalToConstant: view.frame.height) //3900.0
        NSLayoutConstraint.activate([top,bottom,trailing,heightTable,leading])
        view.addSubview(tableView)
        
        setupTableView()
    }
    
    func setupTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: "cell")
        
        let view = MoviePopularHeaderView()
        view.delegate = self
        view.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 320)
        tableView.tableHeaderView = view
        
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
        return 250
    }
  
}
