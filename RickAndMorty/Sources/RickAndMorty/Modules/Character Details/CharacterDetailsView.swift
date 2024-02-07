//
//  CharacterDetailsView.swift
//  RickAndMorty
//
//  Created by Bakur Khalvashi on 01.02.24.
//

import SwiftUI

struct CharacterDetailsView: View {
    //MARK: - Binding Variables
    @ObservedObject var viewModel: CharacterDetailsViewModel
    @State private var selectedEpisodeIndex: Int? = nil
    @State private var selectedEpisode: Episode? = nil
    @State private var selectedCharacter: CharacterItemObject? = nil
    @State private var showAlert = false
    
    var body: some View {
        VStack(alignment: .leading) {
            characterItemView
            episodesTitle
            episodesList
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
                await viewModel.fetchEpisodesForCharacter()
            }
        })
        .navigationTitle("Character Detail")
        .onChange(of: selectedCharacter) { newCharacter in
            withAnimation(.smooth) {
                if let character = newCharacter {
                    Task {
                        await viewModel.fetchCharacter(by: character.id)
                    }
                }
            }
        }
    }
    //MARK: - Character Item View
    private var characterItemView: some View {
        CharacterItemView(
            characterObject: .map(character: viewModel.character),
            imageSize: .free(width: 150, height: 150)
        )
    }
    //MARK: - Episodes Title
    private var episodesTitle: some View {
        Text("Episodes")
            .padding()
            .font(.title)
    }
    //MARK: - Episodes List
    private var episodesList: some View {
        List(0..<viewModel.episodes.count, id: \.self) { index in
            ExpandableEpisodeItemView(
                isExpanded: Binding(
                    get: { selectedEpisodeIndex == index },
                    set: { newValue in
                        if newValue {
                            Task {
                                let episodeId = viewModel.episodes[index].id
                                await viewModel
                                    .fetchCharactersForEpisode(
                                        episodeId: episodeId
                                    )
                            }
                        }
                        selectedEpisodeIndex = newValue ? index : nil
                    }
                ),
                selectedCharacter: $selectedCharacter,
                episode: ExpandableEpisodeItemObject(
                    episode: viewModel.episodes[index].episode,
                    characters: viewModel.charactersForEpisode
                )
            )
        }
    }
}

#Preview {
    CharacterDetailsView(
        viewModel: CharacterDetailsViewModel(
            character: .mock(),
            repository: CharacterDetailsDataRepository(
                apiClient: APIClient()
            )
        )
    )
}
