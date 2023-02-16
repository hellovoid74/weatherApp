//
//  HTTPClient.swift
//  WeatherEmpikApp
//
//  Created by Gleb Lanin on 12/02/2023.
//

import Foundation

protocol HTTPClient {
    func sendRequest<T: Decodable>(
        endpoint: Endpoint,
        responseModel: T.Type,
        completion: @escaping ((Result<T, NetworkError>) -> Void)
    )
}

extension HTTPClient {
    func sendRequest<T: Decodable>(
        endpoint: Endpoint,
        responseModel: T.Type,
        completion: @escaping ((Result<T, NetworkError>) -> Void)
    ) {
        var urlComponents = URLComponents()
        urlComponents.scheme = endpoint.scheme
        urlComponents.host = endpoint.host
        urlComponents.path = endpoint.path
        urlComponents.queryItems = endpoint.header?.compactMap { URLQueryItem(name: $0.key, value: $0.value) }
        
        
        guard let url = urlComponents.url else {
            completion(.failure(.invalidURL))
            return
        }
    
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method.rawValue
        request.allHTTPHeaderFields = endpoint.header
        
        URLSession(configuration: .default).dataTask(with: url) { data, response, error in
            guard
                error == nil,
                let response = response as? HTTPURLResponse,
                (200...299).contains(response.statusCode)
            else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard let receivedData = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let passedData = try JSONDecoder().decode(T.self, from: receivedData)
                completion(.success(passedData))
            }
            catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}
