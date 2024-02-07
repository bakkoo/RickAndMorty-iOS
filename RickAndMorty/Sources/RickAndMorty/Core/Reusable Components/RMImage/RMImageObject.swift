//
//  RMImageObject.swift
//  RickAndMorty
//
//  Created by Bakur Khalvashi on 02.02.24.
//

import Foundation
import SwiftUI

enum RMImageSize {
    case small
    case medium
    case large
    case free(width: CGFloat, height: CGFloat)
}

class RMImageObject: ObservableObject {
    @Published var imageUrl: String
    let imageSize: RMImageSize
    let cornerRadius: CGFloat
    
    init(imageSize: RMImageSize, cornerRadius: CGFloat, imageUrl: String) {
        self.imageSize = imageSize
        self.cornerRadius = cornerRadius
        self.imageUrl = imageUrl
    }
}
