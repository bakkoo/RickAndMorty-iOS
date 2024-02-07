//
//  Character.swift
//  RickAndMorty
//
//  Created by Bakur Khalvashi on 31.01.24.
//

import Foundation

// MARK: - Character
struct CharacterInfo: Codable {
    let info: PaginationInfo
    let results: [Character]
}
