//
//  ImageLoader.swift
//
//
//  Created by Bakur Khalvashi on 01.02.24.
//
 
import Foundation
import SwiftUI

public class ImageLoader {
    private let cache = ImageCache()
    
    func loadImage(from urlString: String) async throws -> Image {
        if let cachedImage = cache.getImage(for: urlString) {
            return Image(uiImage: cachedImage)
        }
        
        let url = try await validateURL(urlString)
        let (data, _) = try await URLSession.shared.data(from: url)
        
        if let image = UIImage(data: data) {
            cache.setImage(image, for: urlString)
            return Image(uiImage: image)
        } else {
            throw ImageLoaderError.invalidImageData
        }
    }
    
    private func validateURL(_ urlString: String) async throws -> URL {
        guard let url = URL(string: urlString) else {
            throw ImageLoaderError.invalidURL
        }
        return url
    }
}
