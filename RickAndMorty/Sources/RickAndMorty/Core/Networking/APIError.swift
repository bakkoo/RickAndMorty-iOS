//
//  APIError.swift
//  RickAndMorty
//
//  Created by Bakur Khalvashi on 30.03.24.
//

import Foundation

public enum APIError: Error {
    case invalidURL
    case networkError(Error?)
    case invalidResponse
    case decodingError(Error)
    case httpError(statusCode: Int, data: Data)
}
