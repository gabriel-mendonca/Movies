//
//  ImageCache.swift
//  Movies
//
//  Created by Gabriel on 08/04/24.
//  Copyright © 2024 Gabriel Mendonça. All rights reserved.
//

import UIKit

class ImageCache {
    static let shared = ImageCache()
    private let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func loadImage(with url: String, completion: @escaping(UIImage?) -> Void) {
        if let cacheImage = cache.object(forKey: url as NSString) {
            completion(cacheImage)
            return
        }
        
        if let imageUrl = URL(string: url) {
            URLSession.shared.dataTask(with: imageUrl) { data, response, error in
                if let data = data, let image = UIImage(data: data) {
                    self.cache.setObject(image, forKey: url as NSString)
                    DispatchQueue.main.async {
                        completion(image)
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(nil)
                    }
                }
            }.resume()
        }
    }
}
