//
//  NetworkService.swift
//  Movies
//
//  Created by Refactoring
//  Copyright © 2021 Gabriel Mendonça. All rights reserved.
//

import Foundation

/// Protocolo para serviços de rede genéricos
protocol NetworkServiceProtocol {
    func request<T: Decodable>(
        url: String,
        responseType: T.Type,
        completion: @escaping (Result<T, NetworkError>) -> Void
    )
}

/// Erros de rede padronizados
enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError(String)
    case networkError(String)
    case unknown
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "URL inválida"
        case .noData:
            return "Nenhum dado recebido"
        case .decodingError(let message):
            return "Erro ao decodificar: \(message)"
        case .networkError(let message):
            return "Erro de rede: \(message)"
        case .unknown:
            return "Erro desconhecido"
        }
    }
}

/// Serviço de rede genérico para reduzir duplicação
class NetworkService: NetworkServiceProtocol {
    
    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(session: URLSession = .shared, decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }
    
    func request<T: Decodable>(
        url: String,
        responseType: T.Type,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        session.dataTask(with: url) { [weak self] data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(.networkError(error.localizedDescription)))
                    return
                }
                
                guard let data = data else {
                    completion(.failure(.noData))
                    return
                }
                
                do {
                    let decodedObject = try self?.decoder.decode(T.self, from: data)
                    if let decodedObject = decodedObject {
                        completion(.success(decodedObject))
                    } else {
                        completion(.failure(.decodingError("Falha ao decodificar objeto")))
                    }
                } catch {
                    let errorMessage = String(data: data, encoding: .utf8) ?? "Erro desconhecido"
                    completion(.failure(.decodingError("\(error.localizedDescription) - \(errorMessage)")))
                }
            }
        }.resume()
    }
}
