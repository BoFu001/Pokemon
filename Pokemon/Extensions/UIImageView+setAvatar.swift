//
//  UIImageView+setAvatar.swift
//  Pokemon
//
//  Created by BoFu on 30/03/2020.
//  Copyright © 2020 BoFu. All rights reserved.
//

import UIKit

extension UIImageView {
    
    static let imageCache = NSCache<AnyObject, AnyObject>()
    
    func setAvatar(url: String) {
        if let cachedImage = UIImageView.imageCache.object(forKey: url as AnyObject) as? UIImage {
            self.image = cachedImage
        }
        else {
            URLSession.shared.dataTask(with: NSURL(string: url)! as URL, completionHandler: { (data, response, error) -> Void in

                if let error = error {
                    print(error)
                } else if let data = data {
                    guard let image = UIImage(data: data) else { return }
                    UIImageView.imageCache.setObject(image, forKey: url as AnyObject)
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            }).resume()
        }
    }
}
