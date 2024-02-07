//
//  CharacterItemView.swift
//  RickAndMorty
//
//  Created by Bakur Khalvashi on 31.01.24.
//

import SwiftUI

struct CharacterItemView: View {
    let characterObject: CharacterItemObject
    var imageSize: RMImageSize
    
    var body: some View {
        HStack {
            VStack {
                Text("\(characterObject.id)")
                    .font(.subheadline)
                    .foregroundStyle(Color.gray)
            }
            RMImage(imageObject: .init(imageSize: imageSize, cornerRadius: 10.0, imageUrl: characterObject.imageUrl)
            )
            
            VStack(alignment: .leading, spacing: 5) {
                Text(characterObject.name)
                    .font(.system(size: 14))
                    .lineLimit(1)
                HStack(alignment: .center, spacing: 5) {
                    Circle()
                        .frame(width: 10, height: 10, alignment: .center)
                        .foregroundStyle(characterObject.status == .alive ? Color.green : Color.red)
                    Text("\(characterObject.status.rawValue) - \(characterObject.species)")
                        .font(.system(size: 10))
                        .lineLimit(1)
                }
                VStack(alignment: .leading, spacing: 5) {
                    Text("Last known location:")
                        .font(.system(size: 10))
                        .foregroundStyle(Color.gray)
                        .lineLimit(1)
                    Text(characterObject.locationName)
                        .font(.system(size: 8))
                        .lineLimit(1)
                }
            }
        }
        .padding(10)
    }
}

#Preview {
    CharacterItemView(characterObject: .mock(), imageSize: .medium)
}
