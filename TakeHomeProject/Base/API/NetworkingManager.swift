//
//  NetworkingManager.swift
//  TakeHomeProject
//
//  Created by Abhijith Chalil on 18/03/25.
//

import Foundation

final class NetworkingManager {
    static let shared = NetworkingManager()
    
    private init() {
    }
    
    func request<T: Codable>(_ endpoint: Endpoint, type: T.Type) async throws -> T {
        
        guard let url = endpoint.url else {
            throw NetworkingError.invalidURL
        }
        
        
        let request = buildRequest(from: url, methodType: endpoint.methodType)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, (200..<300) ~= response.statusCode else {
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            throw NetworkingError.invalidStatusCode(statusCode: statusCode!)
            
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let res = try decoder.decode(T.self, from: data)
        return res
        
    }
    
    func request(_ endpoint: Endpoint) async throws {
        guard let url = endpoint.url else {
            throw NetworkingError.invalidURL
        }
        
        
        let request = buildRequest(from: url, methodType: endpoint.methodType)
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        guard let response = response as? HTTPURLResponse, (200..<300) ~= response.statusCode else {
            let statusCode = (response as? HTTPURLResponse)?.statusCode
            throw NetworkingError.invalidStatusCode(statusCode: statusCode!)
            
        }
        
    }
}

extension NetworkingManager {
    enum NetworkingError: LocalizedError {
        case invalidURL
        case custom(error : Error)
        case invalidStatusCode(statusCode: Int)
        case invalidData
        case failedDecoding(error: Error)
    }
}

extension NetworkingManager.NetworkingError {
    
    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "URL isn't valid"
        case .invalidStatusCode:
            return "Status code falls into the wrong range"
        case .invalidData:
            return "Response data is invalid"
        case .failedDecoding:
            return "Failed to decode"
        case .custom(let err):
            return "Something went wrong \(err.localizedDescription)"
        }
    }
}



private extension NetworkingManager {
    func buildRequest(from url: URL, methodType: Endpoint.MethodType) -> URLRequest {
        var request = URLRequest(url: url)
        
        switch methodType {
        case .GET:
            request.httpMethod = "GET"
        case .POST(let data):
            request.httpMethod = "POST"
            request.httpBody = data
        }
        return request
    }
}
