//
//  ExpandableEpisodeItemView.swift
//  RickAndMorty
//
//  Created by Bakur Khalvashi on 02.02.24.
//

import SwiftUI

struct ExpandableEpisodeItemView: View {
    @Binding var isExpanded: Bool
    @Binding var selectedCharacter: CharacterItemObject?
    let episode: ExpandableEpisodeItemObject
    
    var body: some View {
        VStack {
            HStack {
                Text(episode.episode)
                    .padding()
                Spacer()
                
                withAnimation(.spring) {
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .padding()
                }
            }
            .onTapGesture {
                withAnimation {
                    isExpanded.toggle()
                }
            }
            if isExpanded {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(episode.characters) { character in
                            CharacterItemView(
                                characterObject: character,
                                imageSize: .small
                            )
                            .onTapGesture {
                                selectedCharacter = character
                            }
                        }
                    }
                    .padding()
                }
            }
        }
    }
}


#Preview {
    ExpandableEpisodeItemView(
        isExpanded: .constant(true),
        selectedCharacter: .constant(.mock()),
        episode: .mock())
}
