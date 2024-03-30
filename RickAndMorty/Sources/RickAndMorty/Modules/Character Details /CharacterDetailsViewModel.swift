//
//  CharacterDetailsViewModel.swift
//  RickAndMorty
//
//  Created by Bakur Khalvashi on 30.03.24.
//

import Foundation

//MARK: - View Model Protocol
protocol CharacterDetailsViewModelProtocol: ObservableObject {
    var character: Character { get set }
    var episodes: [Episode] { get set }
    var charactersForEpisode: [CharacterItemObject] { get set }
    var error: Error? { get set }
    
    func fetchEpisodesForCharacter() async
    func fetchCharactersForEpisode(episodeId: Int) async
    func fetchCharacter(by id: Int) async
}
//MARK: - View Model Data Implementation
class CharacterDetailsViewModel: CharacterDetailsViewModelProtocol {
    //MARK: - Binding Variables
    @Published var character: Character
    @Published var episodes: [Episode] = []
    @Published var charactersForEpisode: [CharacterItemObject] = []
    @Published var error: Error?
    //MARK: - Repository
    private var repository: CharacterDetailsRepository
    //MARK: - Initialization
    init(character: Character, repository: CharacterDetailsRepository) {
        self.character = character
        self.repository = repository
    }
    //MARK: - Async Methods
    @MainActor
    func fetchEpisodesForCharacter() async {
        do {
            let episodes = try await withThrowingTaskGroup(of: Episode?.self) { group -> [Episode] in
                var episodesToAdd: [Episode] = []
                
                for episodeUrl in character.episode {
                    if let episodeId = episodeUrl.components(separatedBy: "/").last {
                        group.addTask {
                            do {
                                return try await self.repository.fetchEpisode(from: episodeId)
                            } catch {
                                await self.setError(error: error)
                                return nil
                            }
                        }
                    }
                }
                
                for try await episode in group {
                    if let episode = episode {
                        episodesToAdd.append(episode)
                    }
                }
                
                episodesToAdd.sort { $0.id < $1.id }
                
                return episodesToAdd
            }
            self.episodes = episodes
        } catch {
            self.error = error
        }
    }

    @MainActor
    func fetchCharactersForEpisode(episodeId: Int) async {
        do {
            guard let episode = episodes.first(where: { $0.id == episodeId }) else {
                throw APIError.invalidURL
            }
            
            let characters = try await withThrowingTaskGroup(of: Character?.self) { group -> [Character] in
                var charactersToAdd: [Character] = []
                
                for characterUrl in episode.characters {
                    if let characterId = characterUrl.components(separatedBy: "/").last {
                        
                        group.addTask {
                            do {
                                return try await self.repository.fetchCharacter(id: characterId)
                            } catch {
                                await self.setError(error: error)
                                return nil
                            }
                        }
                    }
                }
                
                for try await character in group {
                    if let character = character {
                        charactersToAdd.append(character)
                    }
                }
                
                charactersToAdd.sort { $0.id < $1.id }
                
                return charactersToAdd
            }
            self.charactersForEpisode = characters.map { .map(character: $0) }
        } catch {
            self.error = error
        }
    }
    
    @MainActor
    func fetchCharacter(by id: Int) async {
        do {
            let selectedCharacter = try await repository.fetchCharacter(id: "\(id)")
            character = selectedCharacter
            await fetchEpisodesForCharacter()
        } catch {
            self.error = error
        }
    }
    
    @MainActor
    private func setError(error: Error) {
        self.error = error
    }
}

