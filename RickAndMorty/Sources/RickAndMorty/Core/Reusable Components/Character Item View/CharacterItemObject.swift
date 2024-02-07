//
//  CharacterItemObject.swift
//  RickAndMorty
//
//  Created by Bakur Khalvashi on 01.02.24.
//

import Foundation
struct CharacterItemObject: Identifiable, Equatable {
    let id: Int
    let name: String
    let imageUrl: String
    let locationName: String
    let status: CharacterStatus
    let species: String
    let originName: String
}
