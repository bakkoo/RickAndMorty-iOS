//
//  SearchCharactersViewModel.swift
//  RickAndMorty
//
//  Created by Bakur Khalvashi on 31.01.24.
//

import Foundation
import Combine
//MARK: - View Model Protocol
protocol SearchCharactersViewModelProtocol: ObservableObject {
    var characters: [Character] { get set }
    var filteredCharacters: [Character] { get set }
    var searchText: String { get set }
    var error: Error? { get set }
    
    func refresh() async
    func fetchCharacters(isRefreshing: Bool) async
    func fetchCharacters(by name: String) async
}
//MARK: - View Model Data Implementation
class SearchCharactersViewModel: SearchCharactersViewModelProtocol {
    //MARK: - Binding Variables
    @Published var characters: [Character] = []
    @Published var filteredCharacters: [Character] = []
    @Published var searchText: String = ""
    @Published var error: Error?
    //MARK: - Cancellables
    private var cancellables: Set<AnyCancellable> = []
    //MARK: - View Model Variables
    private var currentPage: Int = 1
    private var isNextPageAvailable: Bool = true
    var isFetching: Bool = false
    //MARK: - Repository
    private var repository: SearchCharactersRepository
    //MARK: - Initialization
    init(repository: SearchCharactersRepository) {
        self.repository = repository
        setupSearchTextSubscribtion()
    }
    //MARK: - Async Methods
    @MainActor
    func refresh() async {
        guard searchText.isEmpty else { return }
        await fetchCharacters(isRefreshing: true)
    }
    
    @MainActor
    func fetchCharacters(isRefreshing: Bool = false) async {
        defer { isFetching = false }
        guard !isFetching else { return }
        guard searchText.isEmpty else { return }
        guard isNextPageAvailable else { return }
        if isRefreshing {
            characters.removeAll()
            currentPage = 1
        }
        do {
            isFetching = true
            let characters = try await repository.fetchCharacters(with: currentPage)
            self.characters += characters.results
            if characters.info.next == nil {
                isNextPageAvailable = false
            } else {
                currentPage += 1
            }
        } catch {
            self.error = error
        }
    }
    
    @MainActor
    func fetchCharacters(by name: String) async {
        characters.removeAll()
        do {
            let characters = try await repository.fetchCharacters(with: name)
            self.characters = characters.results
        } catch {
            self.error = error
        }
    }

    private func setupSearchTextSubscribtion() {
        $searchText
            .dropFirst()
            .removeDuplicates()
            .debounce(for: .seconds(0.5), scheduler: RunLoop.main)
            .sink { [weak self] searchTerm in
                guard let self = self else { return }
                if searchTerm.isEmpty {
                    Task {
                        await self.refresh()
                    }
                } else if !searchTerm.isEmpty {
                    Task {
                        await self.fetchCharacters(by: searchTerm)
                    }
                }
            }
            .store(in: &cancellables)
    }
}
