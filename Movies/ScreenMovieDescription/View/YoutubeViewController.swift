//
//  Safari.swift
//  Movies
//
//  Created by Gabriel Mendonça Sousa Gonçalves  on 24/01/21.
//  Copyright © 2021 Gabriel Mendonça. All rights reserved.
//

import Foundation
import WebKit
import UIKit


class YoutuberViewController: UIViewController, WKNavigationDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupContraints()
        
        playerView.navigationDelegate = self
                loadingView.hidesWhenStopped = true
                playerView.isHidden = loadingView.isHidden ? true : false
        
    }
    
    
    lazy var playerView: WKWebView = {
           let playerView = WKWebView()
           return playerView
       }()
       
       lazy var loadingView: UIActivityIndicatorView = {
           let loadingView = UIActivityIndicatorView()
           return loadingView
       }()
    
    
    func setupContraints() {
        
        view = playerView
        view.addSubview(loadingView)
        loadingView.startAnimating()
        
        playerView.translatesAutoresizingMaskIntoConstraints = false
        
        let playerTop = playerView.topAnchor.constraint(equalTo: view.topAnchor)
        let playerLeading = playerView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let playerTrailing = playerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let playerBottom = playerView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        NSLayoutConstraint.activate([playerTop,playerLeading,playerTrailing,playerBottom])
        
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        let top = loadingView.topAnchor.constraint(equalTo: view.topAnchor)
        let leading = loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor)
        let trailing = loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        let bottom = loadingView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        NSLayoutConstraint.activate([top,leading,trailing,bottom])
    }
    
    func getVideo(code: String) {
            guard let url = URL(string: "https://www.youtube.com/embed/\(code)") else {
                return
            }
            playerView.load(URLRequest(url: url))
        }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation) {
            loadingView.stopAnimating()
            playerView.isHidden = false
        }
}
