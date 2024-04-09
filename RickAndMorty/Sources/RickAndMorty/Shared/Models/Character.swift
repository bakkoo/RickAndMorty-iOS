//
//  Character.swift
//  RickAndMorty
//
//  Created by Bakur Khalvashi on 31.01.24.
//

import Foundation

// MARK: - Character
struct Character: Codable, Identifiable {
    let id: Int
    let name: String
    let status: CharacterStatus
    let species: String
    let type: String
    let gender: String
    let origin: CharacterLocation
    let location: CharacterLocation
    let image: String
    let episode: [String]
    let url: String
    let created: String
    
    static func mock(id: Int = 1, name: String = "Rick Sanchez") -> Self {
        .init(
            id: id,
            name: name,
            status: .alive,
            species: "Human",
            type: "type",
            gender: "Male",
            origin: CharacterLocation(name: "Earth (C-137)",
                                        url: "https://rickandmortyapi.com/api/location/1"),
            location: CharacterLocation(name: "Citadel of Ricks",
                                        url: "https://rickandmortyapi.com/api/location/3"),
            image: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
            episode:[
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/2",
                "https://rickandmortyapi.com/api/episode/3",
                "https://rickandmortyapi.com/api/episode/4",
                "https://rickandmortyapi.com/api/episode/5",
                "https://rickandmortyapi.com/api/episode/6"
            ],
            url: "https://rickandmortyapi.com/api/character/1",
            created: "2017-11-04T18:48:46.250Z"
        )
    }
}
// MARK: - CharacterLocation
struct CharacterLocation: Codable {
    let name: String
    let url: String
}

// MARK: - Status
enum CharacterStatus: String, Codable, CaseIterable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
}

//MARK: - Gender
enum CharacterGender: String, CaseIterable {
    case female = "Female"
    case male = "Male"
    case genderless = "Genderless"
    case unknown = "unknown"
}
