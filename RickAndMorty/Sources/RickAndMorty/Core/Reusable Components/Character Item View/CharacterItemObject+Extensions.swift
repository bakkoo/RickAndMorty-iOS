//
//  CharacterItemObject+Extensions.swift
//  RickAndMorty
//
//  Created by Bakur Khalvashi on 01.02.24.
//

import Foundation
extension CharacterItemObject {
    /// initializes CharacterItemObject with mock data
    static func mock(id: Int = 1,
                     name: String = "Rick Sanchez",
                     imageUrl: String = "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                     locationName: String = "Citadel of Ricks",
                     status: CharacterStatus = .alive,
                     species: String = "Human",
                     originName: String = "Earth (C-137)") -> Self {
        .init(id: id,
              name: name,
              imageUrl: imageUrl,
              locationName: locationName,
              status: status,
              species: species,
              originName: originName)
    }
    /// initializes CharacterItemObject with Character model
    static func map(character: Character) -> Self {
        .init(id: character.id,
              name: character.name,
              imageUrl: character.image,
              locationName: character.location.name,
              status: character.status,
              species: character.species,
              originName: character.origin.name)
    }
}
