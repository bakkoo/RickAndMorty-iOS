//
//  APIResource.swift
//  RickAndMorty
//
//  Created by Bakur Khalvashi on 30.03.24.
//

import Foundation

public enum APIResource {
    case getCharacters(page: String)
    case getCharactersByName(name: String)
    case getEpisodes(episodeId: String)
    case getCharactersById(id: String)
    
    public var method: HTTPMethod {
        switch self {
        case .getCharacters(_):
            return .get
        case .getCharactersByName(_):
            return .get
        case .getEpisodes(_):
            return .get
        case .getCharactersById(_):
            return .get
        }
    }
    
    public func url(with config: APIConfiguration) async throws -> URL {
        var urlComponents = URLComponents(url: config.baseURL, resolvingAgainstBaseURL: true)!
        
        switch self {
        case let .getCharacters(page):
            urlComponents.path = "/api/character/"
            urlComponents.queryItems = [
                URLQueryItem(name: "page", value: page)
            ]
        case let .getCharactersByName(name):
            urlComponents.path = "/api/character/"
            urlComponents.queryItems = [
                URLQueryItem(name: "name", value: name)
            ]
        case let .getEpisodes(episodeId):
            urlComponents.path = "/api/episode/\(episodeId)"
        case let .getCharactersById(id):
            urlComponents.path = "/api/character/\(id)"
        }
        
        guard let url = urlComponents.url else {
            throw APIError.invalidURL
        }
        
        return url
    }
}

