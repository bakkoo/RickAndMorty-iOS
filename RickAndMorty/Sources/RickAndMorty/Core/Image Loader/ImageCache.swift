//
//  ImageCache.swift
//
//
//  Created by Bakur Khalvashi on 01.02.24.
//

import Foundation
import SwiftUI

class ImageCache {
    private var cache = NSCache<NSString, UIImage>()
    
    func getImage(for key: String) -> UIImage? {
        return cache.object(forKey: key as NSString)
    }
    
    func setImage(_ image: UIImage, for key: String) {
        cache.setObject(image, forKey: key as NSString)
    }
}
