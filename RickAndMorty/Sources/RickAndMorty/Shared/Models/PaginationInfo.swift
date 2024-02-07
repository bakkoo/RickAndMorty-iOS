//
//  CharacterInfo.swift
//  RickAndMorty
//
//  Created by Bakur Khalvashi on 31.01.24.
//

import Foundation

// MARK: - Info
struct PaginationInfo: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
