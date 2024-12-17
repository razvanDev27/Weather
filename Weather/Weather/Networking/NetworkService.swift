//
//  NetworkService.swift
//  Weather
//
//  Created by Razvan Copaciu on 17.12.2024.
//

import Foundation
import Alamofire

class NetworkService {
    
    private lazy var session: Session = {
        let configuration = URLSessionConfiguration.af.default
        configuration.urlCache = nil

        return .init(configuration: configuration)
    }()

    @discardableResult
    func task(url: String,
              parameters: Parameters? = nil,
              method: HTTPMethod,
              encoding: ParameterEncoding = JSONEncoding.default) async throws -> Data {
        try await withCheckedThrowingContinuation { continuation in
            session.request(url, method: method, parameters: parameters, encoding: encoding)
                .validate()
                .responseData { response in
                    switch response.result {
                    case .success(let data):
                        continuation.resume(returning: data)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }
}
