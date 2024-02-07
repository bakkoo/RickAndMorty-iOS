//
//  SearchCharactersViewModelTests.swift
//  RickAndMortyTests
//
//  Created by Bakur Khalvashi on 06.02.24.
//

import XCTest
@testable import RickAndMorty

@MainActor
final class SearchCharactersViewModelTests: XCTestCase {
    var viewModel: SearchCharactersViewModel!
    var repository: MockSearchCharactersRepository!
    
    override func setUp() {
        super.setUp()
        repository = MockSearchCharactersRepository()
        viewModel = SearchCharactersViewModel(repository: repository)
    }
    
    func testFetchCharacters() async throws {
        repository.stubCharacters(with: [.mock(), .mock(id: 2, name: "Morty")])

        await viewModel.fetchCharacters()

        XCTAssertFalse(viewModel.characters.isEmpty)
        XCTAssertNil(viewModel.error)
    }
    
    func testFetchCharactersWithError() async throws {
        repository.stubbedError = NSError(domain: "Test", code: 500, userInfo: nil)

        await viewModel.fetchCharacters()

        XCTAssertTrue(viewModel.characters.isEmpty)
        XCTAssertNotNil(viewModel.error)
    }
    
    func testFetchCharactersByName() async throws {
        let characterName = "Rick"
        repository.stubCharacters(with: [.mock(name: characterName)])

        await viewModel.fetchCharacters(by: characterName)
        
        XCTAssertTrue(viewModel.characters.count > 0)
        XCTAssertNil(viewModel.error)
    }
    
    func testFetchCharactersByNameWithError() async throws {
        let characterName = "NonExistentCharacter"
        repository.stubbedError = NSError(domain: "MockSearchCharactersRepository", code: 404, userInfo: nil)

        await viewModel.fetchCharacters(by: characterName)

        XCTAssertTrue(viewModel.characters.isEmpty)
        XCTAssertNotNil(viewModel.error)
    }
    
    func testRefresh() async throws {
        repository.stubCharacters(with: [.mock()])
        viewModel.characters = [.mock()]

        await viewModel.refresh()
        
        XCTAssertTrue(viewModel.characters.count > 0)
        XCTAssertNil(viewModel.error)
    }
    
    func testFetchCharactersOnSearchTextChange() async throws {
        let characterName = "Morty"
        repository.stubCharacters(with: [.mock(name: characterName)])

        viewModel.searchText = characterName
        try await Task.sleep(nanoseconds: 2_000_000_000)
        XCTAssertTrue(viewModel.characters.count > 0)
        XCTAssertNil(viewModel.error)
    }
    
    func testFetchCharactersOnSearchTextChangeWithError() async throws {
        let characterName = "NonExistentCharacter"
        repository.stubbedError = NSError(domain: "Test", code: 404, userInfo: nil)

        viewModel.searchText = characterName
        try await Task.sleep(nanoseconds: 2_000_000_000)
        XCTAssertTrue(viewModel.characters.isEmpty)
        XCTAssertNotNil(viewModel.error)
    }
}
