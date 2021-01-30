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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNeedsStatusBarAppearanceUpdate()
        setupContraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        movieViewModel.setUpViewController {
            self.tableView.reloadData()
        }
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    lazy var tableView: UITableView = {
       var table = UITableView()
        table.bounces = false
        table.backgroundColor = .black
        view.addSubview(table)
        return table
    }()
    
    func cellTapped(movie: Movie) {
        let movieDescriptionViewModel = MovieDescriptionViewModel(id: movie.id ?? 0)
        let movieDescriptionViewController = MovieDescriptionViewController(movieDescriptionViewModel: movieDescriptionViewModel)
         present(movieDescriptionViewController, animated: true, completion: nil)
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
