//
//  ESNetworking_Lite.swift
//  ESNetworking-Lite
//
//  Created by Dmitriy on 21/06/2020.
//  Copyright © 2020 ESKARIA Corp.. All rights reserved.
//

import Foundation

public struct ESNetworking_Lite {
    
    private var networkService: NetworkServiceProtocol = NetworkService()
    
    public init() {}
    
    /// Run request func
    /// - Parameters:
    ///   - baseUrl: base url for request
    ///   - requestModel: request model with body, path, params. header, type request
    ///   - completionQueue: in which queue run completion. default is ,main
    ///   - cachePolicy: cache policy, default is .useProtocolCachePolicy
    ///   - timeOut: timeout for request. default is 15
    ///   - resultHandler: completion block
    public func request<T: Codable>(baseUrl: String, requestModel: ESRequest, completionQueue: DispatchQueue = .main, cachePolicy: URLRequest.CachePolicy = .useProtocolCachePolicy, timeOut: TimeInterval = 15.0, resultHandler: @escaping (Result<T, ESRequestError>) -> Void) {
        
        self.networkService.request(baseUrl: baseUrl,
                                    requestModel: requestModel,
                                    completionQueue: completionQueue,
                                    cachePolicy: cachePolicy,
                                    timeOut: timeOut,
                                    resultHandler: resultHandler)
    }
}
