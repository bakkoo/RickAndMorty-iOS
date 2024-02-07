//
//  MockCharacterDetailsRepository.swift
//  RickAndMorty
//
//  Created by Bakur Khalvashi on 06.02.24.
//

import Foundation

class MockCharacterDetailsRepository: CharacterDetailsRepository {
    var stubbedEpisodes: [Episode] = []
    var stubbedCharacters: [Character] = []
    var stubbedCharacter: Character?
    var stubbedError: Error?
    
    func fetchEpisode(from episodeId: String) async throws -> Episode {
        if let error = stubbedError {
            throw error
        } else {
            guard let episode = stubbedEpisodes.first(where: { "\($0.id)" == episodeId }) else {
                throw NSError(domain: "MockCharacterDetailsRepository", code: 404, userInfo: [NSLocalizedDescriptionKey: "Episode not found"])
            }
            return episode
        }
    }
    
    func fetchCharacter(id: String) async throws -> Character {
        if let error = stubbedError {
            throw error
        } else if let character = stubbedCharacter, "\(character.id)" == id {
            return character
        } else {
            throw NSError(domain: "MockCharacterDetailsRepository", code: 404, userInfo: [NSLocalizedDescriptionKey: "Character not found"])
        }
    }
    
    func stubEpisodes(_ episodes: [Episode]) {
        stubbedEpisodes = episodes
    }
    
    func stubCharacters(_ characters: [Character]) {
        stubbedCharacters = characters
    }
    
    func stubCharacter(_ character: Character) {
        stubbedCharacter = character
    }
    
    func stubError(_ error: Error?) {
        stubbedError = error
    }
}
