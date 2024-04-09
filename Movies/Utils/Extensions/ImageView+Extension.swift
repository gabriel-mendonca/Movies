//
//  ImageView+Extension.swift
//  Movies
//
//  Created by Gabriel on 08/04/24.
//  Copyright © 2024 Gabriel Mendonça. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func renderImageView(urlImage: String) {
        ImageCache.shared.loadImage(with: urlImage) { [weak self] image in
            guard let self else { return }
            guard let image = image else { return }
            self.image = image
        }
    }
}
