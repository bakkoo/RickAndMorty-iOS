//
//  Episode.swift
//  RickAndMorty
//
//  Created by Bakur Khalvashi on 01.02.24.
//

import Foundation

struct Episode: Codable, Identifiable {
    let id: Int
    let episode: String
    let characters: [String]
    
    static func mock(
        id: Int = 1,
        episode: String = "https://rickandmortyapi.com/api/episode/1",
        characters: [String] = [
            "https://rickandmortyapi.com/api/character/1",
            "https://rickandmortyapi.com/api/character/2",
            "https://rickandmortyapi.com/api/character/3"]) -> Self {
        .init(
            id: id,
              episode: episode,
              characters: characters
        )
    }
}
