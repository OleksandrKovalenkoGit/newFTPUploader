//
//  APIManager.swift
//  NewFTPUploader
//
//  Created by Golos on 03.04.2020.
//  Copyright © 2020 ITC. All rights reserved.
//

import Foundation
import Combine
import Network

protocol APIProviderProtocol {
    func dataTaskPublisher(for request: URLRequest) -> URLSession.DataTaskPublisher
}

// MARK: APIProviderProtocol
extension URLSession: APIProviderProtocol {}

protocol APIManagerProtocol {
    func perform<T: Decodable>(request: APIRequest<T>) -> AnyPublisher<T, Error>
}

struct APIManager {
    let apiProvider: APIProviderProtocol
    let queryHelper: QueryHelperProtocol
    let encoder: APIEncoderProtocol
    let decoder: JSONDecoder
    let token: () -> String?
    let baseUrl: String
}

// MARK: APIManagerProtocol
extension APIManager: APIManagerProtocol {
    func perform<T: Decodable>(request: APIRequest<T>) -> AnyPublisher<T, Error> {
        let urlString = baseUrl
            .appending("api.php?action=")
            .appending(request.requestName)
        
        var getParameters = request.getParameters
        getParameters?["access_token"] = request.isTokenRequired ? token() : nil
        
        guard let baseURL = queryHelper.encode(urlString, with: getParameters) else {
            return Fail(error: APIError.wrongURLSettings).eraseToAnyPublisher()
        }
        var urlRequest = URLRequest(url: baseURL)
        urlRequest.httpMethod = request.httpMethod.rawValue.uppercased()
        
        if let postParameters = request.postParameters {
            urlRequest.httpBody = encoder.encode(parameters: postParameters)
        }
        return apiProvider
            .dataTaskPublisher(for: urlRequest)
            .mapError(APIError.init)
            .tryMap { response in
//                print("API: " + String(data: response.data, encoding: .utf8).orEmpty)
                
                guard let apiError = try? self.decoder.decode(ApiErrorModel.self, from: response.data) else {
                    return response.data
                }
                throw APIError.apiError(apiError.error)
            }
            .decode(type: T.self, decoder: decoder)
            .eraseToAnyPublisher()
    }
}
