//
//  MockSearchCharactersRepository.swift
//  RickAndMorty
//
//  Created by Bakur Khalvashi on 06.02.24.
//

import Foundation

class MockSearchCharactersRepository: SearchCharactersRepository {
    var stubbedCharacters: [Character] = []
    var stubbedError: Error?
    
    init() {}
    
    func fetchCharacters(with page: Int) async throws -> CharacterInfo {
        if let error = stubbedError {
            throw error
        } else {
            let startIndex = (page - 1) * 20
            let endIndex = min(startIndex + 20, stubbedCharacters.count)
            let charactersForPage = Array(stubbedCharacters[startIndex..<endIndex])
            let paginationInfo = PaginationInfo(count: stubbedCharacters.count, pages: 40, next: "2", prev: "1")
            return CharacterInfo(info: paginationInfo, results: charactersForPage)
        }
    }
    
    func fetchCharacters(with name: String) async throws -> CharacterInfo {
        if let error = stubbedError {
            throw error
        } else {
            let filteredCharacters = stubbedCharacters.filter { $0.name == name }
            return CharacterInfo(info: PaginationInfo(count: filteredCharacters.count, pages: 1, next: nil, prev: nil), results: filteredCharacters)
        }
    }
    
    func stubCharacters(with characters: [Character]) {
        stubbedCharacters = characters
    }
    
    func stubError(with error: Error?) {
        stubbedError = error
    }
}
