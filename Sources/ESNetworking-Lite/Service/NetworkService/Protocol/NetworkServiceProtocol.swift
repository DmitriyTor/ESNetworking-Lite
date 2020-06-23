//
//  NetworkServiceProtocol.swift
//  ESNetworking-Lite
//
//  Created by Dmitriy on 21/06/2020.
//  Copyright © 2020 ESKARIA Corp.. All rights reserved.
//

import Foundation

protocol NetworkServiceProtocol {
    /// Run request func
    /// - Parameters:
    ///   - baseUrl: base url for request
    ///   - requestModel: request model with body, path, params. header, type request
    ///   - completionQueue: in which queue run completion
    ///   - cachePolicy: cache policy
    ///   - timeOut: timeout for request
    ///   - resultHandler: completion block
    func request<T: Codable>(baseUrl: String, requestModel: ESRequest, completionQueue: DispatchQueue, cachePolicy: URLRequest.CachePolicy, timeOut: TimeInterval, progressHandler: ((Float) -> Void)?, resultHandler: @escaping (Result<T, ESRequestError>) -> Void)
}
