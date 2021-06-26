//
//  ScreenError.swift
//  Movies
//
//  Created by Gabriel Mendonça Sousa Gonçalves  on 23/01/21.
//  Copyright © 2021 Gabriel Mendonça. All rights reserved.
//

import UIKit

class ScreenError: UIView {
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setupContraints()
//        view.backgroundColor = .white
//    }
    
    var viewController: UIViewController?
    var text: String?
    var image: UIImage?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupContraints()
        self.cornerRadius()
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    lazy var errorImage: UIImageView = {
        var imageError = UIImageView()
        imageError.image = #imageLiteral(resourceName: "ErrorConnect")
        imageError.contentMode = .scaleToFill
        self.addSubview(imageError)
        return imageError
    }()
    
    lazy var bottomBack: UIButton = {
       var bottom = UIButton()
        bottom.setTitle("Voltar", for: .normal)
        bottom.tintColor = .white
        bottom.addTarget(self, action: #selector(exitError), for: .touchUpInside)
        bottom.backgroundColor = .black
        self.addSubview(bottom)
        return bottom
    }()
    
    lazy var backError: UIButton = {
       var back = UIButton()
        back.setImage(UIImage(named: "backButton"), for: .normal)
        back.addTarget(self, action: #selector(exitError), for: .touchUpInside)
        self.addSubview(back)
        return back
    }()

    lazy var errorTitle: UILabel = {
        var label = UILabel()
        label.text = "Ocorreu um erro ao conectar com a internet, verifique sua conexão com a internet!"
        label.numberOfLines = 0
        label.textAlignment = .center
        self.addSubview(label)
        return label
    }()
    
    @objc func exitError() {
        viewController?.navigationController?.popViewController(animated: true)
    }
    
    func setup(viewController: UIViewController?) {
        self.viewController = viewController
        
    }
    
    func cornerRadius() {
        bottomBack.clipsToBounds = true
        bottomBack.layer.cornerRadius = 10
    }
    
    func setupContraints() {
        
        errorImage.translatesAutoresizingMaskIntoConstraints = false
        errorTitle.translatesAutoresizingMaskIntoConstraints = false
        backError.translatesAutoresizingMaskIntoConstraints = false
        bottomBack.translatesAutoresizingMaskIntoConstraints = false
        
        
        let bottomButton = bottomBack.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor,constant: -15)
        let leadingButton = bottomBack.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 16)
        let trailingButton = bottomBack.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -16)
        let heightButton = bottomBack.heightAnchor.constraint(equalToConstant: 50)
        NSLayoutConstraint.activate([bottomButton,leadingButton,trailingButton,heightButton])
        self.addSubview(bottomBack)
        
        let topBack = backError.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor,constant: 10)
        let leadingBack = backError.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 15)
        let heightBack = backError.heightAnchor.constraint(equalToConstant: 30)
        let widhtBack = backError.widthAnchor.constraint(equalToConstant: 30)
        NSLayoutConstraint.activate([topBack,leadingBack,heightBack,widhtBack])
        self.addSubview(backError)
        
        let imageCenterY = errorImage.topAnchor.constraint(equalTo: self.topAnchor,constant: 150)
        let imageCenterX = errorImage.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        let imageHeight = errorImage.heightAnchor.constraint(equalToConstant: 200)
        let imageWidht = errorImage.widthAnchor.constraint(equalToConstant: 200)
        NSLayoutConstraint.activate([imageCenterY,imageCenterX,imageHeight,imageWidht])
        self.addSubview(errorImage)
        
        let topTitle = errorTitle.topAnchor.constraint(equalTo: errorImage.bottomAnchor, constant: 20)
        let leadingTitle = errorTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10)
        let trailingTitle = errorTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10)
        NSLayoutConstraint.activate([topTitle,leadingTitle,trailingTitle])
        self.addSubview(errorTitle)
        
    }
    
    
}
