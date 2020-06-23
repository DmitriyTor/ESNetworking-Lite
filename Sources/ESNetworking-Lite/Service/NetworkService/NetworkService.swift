//
//  NetworkService.swift
//  ESNetworking-Lite
//
//  Created by Dmitriy on 21/06/2020.
//  Copyright © 2020 ESKARIA Corp.. All rights reserved.
//

import Foundation

final class NetworkService {
    
    private let JSONCoder: ESJSONCoderProtocol
    private var progressObservation: NSKeyValueObservation?
    private var progressHandler: ((Float) -> Void)?
    private var progress: Float
    
    init() {
        self.JSONCoder = ESJSONCoder()
        self.progress = 0
    }
    
    deinit {
        progressObservation?.invalidate()
    }
    
    /// Make url request
    /// - Parameters:
    ///   - request: request
    ///   - resultHandler: request result with generic parameter T (model) and error
    private func makeUrlRequest<T: Codable>(_ request: URLRequest, progressHandler: ((Float) -> Void)?, resultHandler: @escaping (Result<T, ESRequestError>) -> Void) {
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
        progressObservation = urlTask.progress.observe(\.fractionCompleted) { progressValue, _ in
            let currentProgress = Float(progressValue.fractionCompleted).rounded(toPlaces: 2)
            if !(self.progress == currentProgress) && !(self.progress > currentProgress) {
                self.progress = currentProgress
                progressHandler?(self.progress)
            }
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

extension NetworkService: NetworkServiceProtocol {
    
    /// Run request func
    /// - Parameters:
    ///   - baseUrl: base url for request
    ///   - requestModel: request model with body, path, params. header, type request
    ///   - completionQueue: in which queue run completion
    ///   - cachePolicy: cache policy
    ///   - timeOut: timeout for request
    ///   - resultHandler: completion block
    ///   - progressHandler: Progress handler with Float loading progress from 0 to 1
    func request<T: Codable>(baseUrl: String, requestModel: ESRequest, completionQueue: DispatchQueue, cachePolicy: URLRequest.CachePolicy, timeOut: TimeInterval, progressHandler: ((Float) -> Void)?, resultHandler: @escaping (Result<T, ESRequestError>) -> Void) {
        
        self.progress = 0
        
        var urlComponents = URLComponents(string: baseUrl + requestModel.path)
        
        // add url params to request
        for (paramName, paramValue) in requestModel.urlParameters {
            urlComponents?.queryItems?.append(URLQueryItem(name: paramName, value: "\(paramValue)"))
        }
        
        // create URLRequest
        guard let url = urlComponents?.url else {
            completionQueue.async {
                resultHandler(.failure(.wrongURL))
            }
            return
        }
        var request = URLRequest(url: url, cachePolicy: cachePolicy, timeoutInterval: timeOut)
        
        // add header
        for (paramName, paramValue) in requestModel.headers {
            request.addValue(paramValue, forHTTPHeaderField: paramName)
        }
        
        // add bodyParams
        if requestModel.bodyParameters.count > 0 {
            do {
                let jsonBody = try JSONSerialization.data(withJSONObject: requestModel.bodyParameters, options: .prettyPrinted)
                request.httpBody = jsonBody
            } catch {
                completionQueue.async {
                    resultHandler(.failure(.wrongBodyParams))
                }
            }
        }
        
        // method
        request.httpMethod = requestModel.method.rawValue
        
        //run request
        makeUrlRequest(request, progressHandler: progressHandler) { (result: Result<T, ESRequestError>) in
            completionQueue.async {
                resultHandler(result)
                self.progressObservation?.invalidate()
            }
        }
    }
}
