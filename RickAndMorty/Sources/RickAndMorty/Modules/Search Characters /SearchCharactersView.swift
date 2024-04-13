//
//  SearchCharactersView.swift
//  RickAndMorty
//
//  Created by Bakur Khalvashi on 30.03.24.
//

import SwiftUI

struct SearchCharactersView: View {
    //MARK: - Binding Variables
    @ObservedObject var viewModel: SearchCharactersViewModel
    @State private var showAlert = false
    @State private var showFilter = false
    
    var body: some View {
        NavigationView {
            VStack {
                characterList
                .searchable(text: $viewModel.searchText)
                .refreshable {
                    Task {
                        await viewModel.refresh()
                    }
                }
                .onReceive(viewModel.$error, perform: { err in
                    if err != nil {
                        showAlert.toggle()
                    }
                })
                .alert(isPresented: $showAlert, content: {
                    Alert(
                        title: Text("Error"),
                        message: Text(viewModel.error?.localizedDescription ?? "Something went wrong...")
                    )
                })
            }
            .onAppear(perform: {
                Task {
                    await viewModel.fetchCharacters()
                }
            })
            .navigationTitle("Search Characters")
        }
    }
    //MARK: - Character List
    private var characterList: some View {
        List(viewModel.characters) { character in
            NavigationLink(
                destination:
                    CharacterDetailsView(
                        viewModel: CharacterDetailsViewModel(
                            character: character,
                            repository: CharacterDetailsDataRepository(
                                apiClient: APIClient()
                            )
                        )
                    )
            ) {
                CharacterItemView(
                    characterObject: .map(character: character), imageSize: .medium
                )
            }
            .onAppear {
                if character.id == viewModel.characters.last?.id {
                    Task {
                        await viewModel.fetchCharacters()
                    }
                }
            }
            
        }
    }
}

#Preview {
    SearchCharactersView(
        viewModel: SearchCharactersViewModel(
            repository: SearchCharactersDataRepository(
                apiClient: APIClient()
            )
        )
    )
}
