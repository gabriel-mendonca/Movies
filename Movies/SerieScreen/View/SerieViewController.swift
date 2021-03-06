//
//  SerieViewController.swift
//  Movies
//
//  Created by Gabriel Mendonça on 13/07/20.
//  Copyright © 2020 Gabriel Mendonça. All rights reserved.
//

import Foundation
import UIKit

class SerieViewController: UIViewController,UITableViewDataSource,UITableViewDelegate, SerieCollectionViewCellDelegate {
  
    var serieViewModel: SerieViewModel = SerieViewModel()
    var serieTableViewCellViewModel: SerieTableViewCellViewModel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableViewContraints()
        setupSerieTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        hideNavigationBar(animated)
        super.viewWillAppear(animated)
        serieViewModel.setupSerieTableView {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    init(viewModel: SerieTableViewCellViewModel) {
        self.serieTableViewCellViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
      lazy var tableView: UITableView = {
         var table = UITableView()
        table.allowsSelection = false
        table.backgroundColor = .black
          view.addSubview(table)
          return table
      }()
    
    func cellTapped(_ model: Serie) {
        serieTableViewCellViewModel.showSeries(model: model)
    }
  
    func setupTableViewContraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        let top = tableView.topAnchor.constraint(equalTo: view.topAnchor)
        let bottom = tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        let leading = tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let trailing = tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        NSLayoutConstraint.activate([top,bottom,leading,trailing])
        view.addSubview(tableView)
    }
        
        func setupSerieTableView() {
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SerieTableViewCell.self, forCellReuseIdentifier: "cell")
            
            let view = SeriePopularheaderView()
            view.frame = CGRect(x: 0, y: 10, width: tableView.frame.width, height: 320)
            view.delegate = self
            tableView.tableHeaderView = view
    }
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return serieViewModel.numberOfSerie()
       }
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SerieTableViewCell
        cell.cellConfigurate(name: serieViewModel.getSerie(at: indexPath.row).0)
        cell.serieTableViewCellViewModel.id = serieViewModel.getSerie(at: indexPath.row).1
        cell.setupSerieCollectionView(view: self)
        cell.delegate = self
        cell.setupSerieCollectionViewContraints()
        cell.backgroundColor = .black
        return cell
       }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }
       
       
    
}
