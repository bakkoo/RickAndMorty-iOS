//
//  ImageLoadState.swift
//  
//
//  Created by Bakur Khalvashi on 01.02.24.
//

import Foundation
import SwiftUI

public enum ImageLoadState {
    case loading
    case success(Image)
    case failure(Error)
}
