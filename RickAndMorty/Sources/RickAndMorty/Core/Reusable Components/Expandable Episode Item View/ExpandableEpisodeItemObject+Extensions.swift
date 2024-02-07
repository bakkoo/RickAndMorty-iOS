//
//  ExpandableEpisodeItemObject+Extensions.swift
//  RickAndMorty
//
//  Created by Bakur Khalvashi on 02.02.24.
//

import Foundation
extension ExpandableEpisodeItemObject {
    /// initializes mock episode
    static func mock() -> Self {
        .init(episode: "S01E01", characters: [.mock(id: 1),.mock(id: 2),.mock(id: 3),.mock(id: 4)])
    }
}
