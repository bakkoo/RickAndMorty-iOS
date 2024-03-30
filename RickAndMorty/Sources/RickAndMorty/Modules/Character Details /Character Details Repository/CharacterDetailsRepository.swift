//
//  CharacterDetailsRepository.swift
//  RickAndMorty
//
//  Created by Bakur Khalvashi on 01.02.24.
//

import Foundation
//MARK: - Repository Protocol
protocol CharacterDetailsRepository: AnyObject {
    func fetchEpisode(from episodeId: String) async throws -> Episode
    func fetchCharacter(id: String) async throws -> Character
}
//MARK: - Repository Data Implementation
class CharacterDetailsDataRepository: CharacterDetailsRepository {
    //MARK: - Variables
    let apiClient: APIClientProtocol
    //MARK: - Initialization
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    //MARK: - Async Throwing Methods
    func fetchEpisode(from episodeId: String) async throws -> Episode {
        return try await apiClient.request(endpoint: .getEpisodes(episodeId: episodeId),
                                           apiConfiguration: .rickAndMortyApi,
                                           type: Episode.self)
    }
    
    func fetchCharacter(id: String) async throws -> Character {
        return try await apiClient.request(endpoint: .getCharactersById(id: id),
                                           apiConfiguration: .rickAndMortyApi,
                                           type: Character.self)
    }
}
