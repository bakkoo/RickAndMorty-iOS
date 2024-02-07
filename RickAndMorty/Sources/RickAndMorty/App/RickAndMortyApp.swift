//
//  RickAndMortyApp.swift
//  RickAndMorty
//
//  Created by Bakur Khalvashi on 31.01.24.
//

import SwiftUI

@main
struct RickAndMortyApp: App {
    var body: some Scene {
        WindowGroup {
            SearchCharactersView(viewModel: SearchCharactersViewModel(repository: SearchCharactersDataRepository(apiClient: APIClient())))
        }
    }
}
