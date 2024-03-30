//
//  ImageFetcher.swift
//
//
//  Created by Bakur Khalvashi on 01.02.24.
//

import Foundation
import SwiftUI

@MainActor
public class ImageFetcher: ObservableObject {
    public init() { }
    
    @Published public var state: ImageLoadState = .loading
    
    private let imageLoader = ImageLoader()
    
    public func loadImage(from urlString: String, placeholder: Image? = nil) {
        state = .loading
        
        if let placeholder = placeholder {
            state = .success(placeholder)
        }
        
        Task {
            do {
                let image = try await imageLoader.loadImage(from: urlString)
                state = .success(image)
            } catch {
                state = .failure(error)
            }
        }
    }
}
