//
//  NetworkService.swift
//  ESNetworking-Lite
//
//  Created by Dmitriy on 21/06/2020.
//  Copyright © 2020 ESKARIA Corp.. All rights reserved.
//

import Foundation

struct NetworkService {
    
    private var JSONCoder = ESJSONCoder()
    
    /// Make url request
    /// - Parameters:
    ///   - request: request
    ///   - resultHandler: request result with generic parameter T (model) and error
    func makeUrlRequest<T: Codable>(_ request: URLRequest, resultHandler: @escaping (Result<T, ESRequestError>) -> Void) {
        let urlTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            let statusCode = self.getStatusCode(response: response)
            let errorType = self.getErrorType(from: statusCode)
            
            // check error and status code in 200 range
            guard error == nil, 200...299 ~= statusCode else {
                resultHandler(.failure(errorType))
                return
            }
            
            // check data if nil
            guard let data = data else {
                resultHandler(.failure(.noData))
                return
            }
            
            //decode data
            let decodedResult: (decodedModel: T?, error: Error?) = self.JSONCoder.decodedData(data)
            
            guard let decodedData: T = decodedResult.decodedModel else {
                resultHandler(.failure(.dataDecodingError))
                return
            }
            
            resultHandler(.success(decodedData))
        }
        
        urlTask.resume()
    }
    
    
    
    /// Get error type from status code
    /// - Parameter statusCode: status code
    /// - Returns: error's type
    private func getErrorType(from statusCode: Int) -> ESRequestError {
        
        var networkErrorType = ESRequestError.unspecified(statusCode: statusCode)
        switch statusCode {
        case URLError.notConnectedToInternet.rawValue, URLError.cannotFindHost.rawValue, URLError.cannotConnectToHost.rawValue:
            networkErrorType = .noConnection
        case URLError.timedOut.rawValue:
            networkErrorType = .timedOut
        case URLError.networkConnectionLost.rawValue:
            networkErrorType = .lostConnection
        case 400:
            networkErrorType = .badRequest
        case 401:
            networkErrorType = .unauthorized
        case 404:
            networkErrorType = .notFound
        case 403:
            networkErrorType = .forbidden
        case 500...599:
            networkErrorType = .internalServerError
        default:
            networkErrorType = .unspecified(statusCode: statusCode)
        }
        return networkErrorType
    }
    
    /// Get status code from URLREsponse
    /// - Parameter response: response
    /// - Returns: return status code in Int format
    private func getStatusCode(response: URLResponse?) -> Int {
        ((response as? HTTPURLResponse)?.statusCode ?? 9999)
    }
}
