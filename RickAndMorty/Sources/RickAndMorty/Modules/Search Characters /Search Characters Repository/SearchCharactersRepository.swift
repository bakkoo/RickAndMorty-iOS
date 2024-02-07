//
//  SearchCharactersRepository.swift
//  RickAndMorty
//
//  Created by Bakur Khalvashi on 31.01.24.
//

import Foundation
//MARK: - Repository Protocol
protocol SearchCharactersRepository: AnyObject {
    func fetchCharacters(with page: Int) async throws -> CharacterInfo
    func fetchCharacters(with name: String) async throws -> CharacterInfo
}
//MARK: - Repository Data Implementation
class SearchCharactersDataRepository: SearchCharactersRepository {
    //MARK: - Variables
    private let apiClient: APIClientProtocol
    //MARK: - Initialization
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    //MARK: - Async Throwing Methods
    func fetchCharacters(with page: Int) async throws -> CharacterInfo {
        try await apiClient.request(endpoint: .getCharacters(page: "\(page)"), apiConfiguration: .rickAndMortyApi, type: CharacterInfo.self)
    }
    
    func fetchCharacters(with name: String) async throws -> CharacterInfo {
        try await apiClient.request(endpoint: .getCharactersByName(name: name), apiConfiguration: .rickAndMortyApi, type: CharacterInfo.self)
    }
}
