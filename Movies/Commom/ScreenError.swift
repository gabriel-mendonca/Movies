//
//  ScreenError.swift
//  Movies
//
//  Created by Gabriel Mendonça Sousa Gonçalves  on 23/01/21.
//  Copyright © 2021 Gabriel Mendonça. All rights reserved.
//

import UIKit

class ScreenError: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupContraints()
        view.backgroundColor = .white
    }
    
    
    lazy var errorImage: UIImageView = {
        var imageError = UIImageView()
        imageError.image = #imageLiteral(resourceName: "error404")
        view.addSubview(imageError)
        return imageError
    }()

    lazy var errorTitle: UILabel = {
        var label = UILabel()
        label.text = "Error"
        label.textAlignment = .center
        view.addSubview(label)
        return label
    }()
    
    func show() {
        let controller = self
        let window = UIApplication.shared.delegate?.window ?? UIWindow()
        window?.rootViewController?.present(controller, animated: true, completion: nil)
    }
    
    func setupContraints() {
        
        errorImage.translatesAutoresizingMaskIntoConstraints = false
        errorTitle.translatesAutoresizingMaskIntoConstraints = false
        
        let imageCenterY = errorImage.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        let imageCenterX = errorImage.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        let imageHeight = errorImage.heightAnchor.constraint(equalToConstant: 300)
        NSLayoutConstraint.activate([imageCenterY,imageCenterX,imageHeight])
        view.addSubview(errorImage)
        
        let topTitle = errorTitle.topAnchor.constraint(equalTo: errorImage.bottomAnchor, constant: 20)
        let leadingTitle = errorTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10)
        let trailingTitle = errorTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10)
        NSLayoutConstraint.activate([topTitle,leadingTitle,trailingTitle])
        view.addSubview(errorTitle)
        
    }
    
    
}
