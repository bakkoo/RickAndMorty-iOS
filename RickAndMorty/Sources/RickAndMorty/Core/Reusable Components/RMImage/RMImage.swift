//
//  RMImage.swift
//  RickAndMorty
//
//  Created by Bakur Khalvashi on 02.02.24.
//

import SwiftUI

struct RMImage: View {
    @StateObject private var imageFetcher = ImageFetcher()
    @ObservedObject var imageObject: RMImageObject
    
    var body: some View {
        HStack {
            switch imageFetcher.state {
            case .loading:
                ProgressView()
                    .frame(width: imageSize().0, height: imageSize().1)
            case let .success(image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: imageSize().0, height: imageSize().1)
                    .clipShape(RoundedRectangle(cornerRadius: imageObject.cornerRadius))
            case let .failure(err):
                VStack {
                    Text("Error: \(err.localizedDescription)")
                    Button(action: {
                        imageFetcher.loadImage(from: imageObject.imageUrl)
                    }) {
                        Image(systemName: "arrow.counterclockwise.circle.fill")
                            .foregroundColor(.blue)
                            .font(.system(size: 24))
                            .padding()
                    }
                }
            }
        }
        .onAppear(perform: {
            imageFetcher.loadImage(from: imageObject.imageUrl)
        })
        
        .onChange(of: imageObject.imageUrl) { newImage in
            imageFetcher.loadImage(from: newImage)
        }
    }
    
    private func imageSize() -> (CGFloat, CGFloat) {
        switch imageObject.imageSize {
        case .small:
            return (50.0, 50.0)
        case .medium:
            return (75.0, 75.0)
        case .large:
            return (100.0, 100.0)
        case let .free(width, height):
            return (width, height)
        }
    }
    
    private func loadInitialImage() {
        imageFetcher.loadImage(from: imageObject.imageUrl)
    }
}

#Preview {
    RMImage(imageObject: .init(
        imageSize: .medium,
        cornerRadius: 10.0, imageUrl: ""))
}
