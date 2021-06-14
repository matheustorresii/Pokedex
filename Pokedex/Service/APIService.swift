//
//  APIService.swift
//  Pokedex
//
//  Created by Matheus Torres on 12/06/21.
//

import Foundation
import Alamofire

protocol APIEndpoint {
    var url: String { get }
}

class APIService {
    enum RequestError: Error {
        case connection
        case client
        case server
        case parsing
        case unknown
    }
    
    static func request<T: Decodable>(_ endpoint: APIEndpoint, completion: @escaping (Swift.Result<T, RequestError>) -> Void) {
        AF.request(endpoint.url).response { req in
            if let error = req.error {
                print(error)
                completion(.failure(.connection))
            } else if let data = req.data, let response = req.response {
                do {
                    let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                    switch response.statusCode {
                        case 200:
                            completion(.success(decodedResponse))
                        case 400...499:
                            completion(.failure(.client))
                        case 500...599:
                            completion(.failure(.server))
                        default:
                            completion(.failure(.unknown))
                    }
                } catch let parseError {
                    completion(.failure(.parsing))
                    print("Parsing error: \(parseError)")
                }
            } else {
                completion(.failure(.connection))
            }
        }
    }
    
    static func getErrorMessage(for error: RequestError) -> String {
        print(error)
        switch error {
            case .connection: return "Didn't find any Pokemon."
            case .client: return "Client error :("
            case .parsing: return "Parsing error :("
            case .server: return "Server is down, try again later."
            case .unknown: return "Unknown error."
        }
    }
}
