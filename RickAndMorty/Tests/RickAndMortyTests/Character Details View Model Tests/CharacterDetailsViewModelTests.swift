//
//  CharacterDetailsViewModelTests.swift
//  RickAndMortyTests
//
//  Created by Bakur Khalvashi on 06.02.24.
//

import XCTest
@testable import RickAndMorty

class CharacterDetailsViewModelTests: XCTestCase {
    var viewModel: CharacterDetailsViewModel!
    var repository: MockCharacterDetailsRepository!
    
    override func setUp() {
        super.setUp()
        repository = MockCharacterDetailsRepository()
        viewModel = CharacterDetailsViewModel(character: .mock(), repository: repository)
    }
    
    func testFetchEpisodesForCharacter_Success() async throws {
        let episodes = [Episode.mock(id: 1),
                        Episode.mock(id: 2),
                        Episode.mock(id: 3),
                        Episode.mock(id: 4),
                        Episode.mock(id: 5),
                        Episode.mock(id: 6)]
        
        repository.stubEpisodes(episodes)
        
        await viewModel.fetchEpisodesForCharacter()
        
        XCTAssertEqual(viewModel.episodes.count, episodes.count)
        XCTAssertNil(viewModel.error)
    }
    
    func testFetchEpisodesForCharacter_Error() async throws {
        repository.stubError(NSError(domain: "MockError", code: 500, userInfo: nil))
        
        await viewModel.fetchEpisodesForCharacter()
        
        XCTAssertTrue(viewModel.episodes.isEmpty)
        XCTAssertNotNil(viewModel.error)
    }

    func testFetchCharactersForEpisode_Error() async throws {
        repository.stubError(NSError(domain: "MockError", code: 500, userInfo: nil))
        let episodeId = 1
        
        await viewModel.fetchCharactersForEpisode(episodeId: episodeId)
        
        XCTAssertTrue(viewModel.charactersForEpisode.isEmpty)
        XCTAssertNotNil(viewModel.error)
    }
    
    func testFetchCharacter_Success() async throws {
        let character = Character.mock(id: 1)
        repository.stubCharacter(character)
        
        await viewModel.fetchCharacter(by: character.id)
        
        XCTAssertEqual(viewModel.character.id, character.id)
    }
    
    func testFetchCharacter_Error() async throws {
        repository.stubError(NSError(domain: "MockError", code: 500, userInfo: nil))
        
        await viewModel.fetchCharacter(by: 1)
        
        XCTAssertNotNil(viewModel.error)
    }
}
