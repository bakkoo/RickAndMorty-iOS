//
//  APIConfiguration.swift
//  RickAndMorty
//
//  Created by Bakur Khalvashi on 30.03.24.
//

import Foundation

public struct APIConfiguration {
    let baseURL: URL
    let apiKey: String

    public static let rickAndMortyApi = APIConfiguration(
        baseURL: URL(string: "https://rickandmortyapi.com")!,
        apiKey: ""
    )
}
