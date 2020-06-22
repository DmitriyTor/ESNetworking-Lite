//
//  NetworkServiceProtocol.swift
//  ESNetworking-Lite
//
//  Created by Dmitriy on 21/06/2020.
//  Copyright © 2020 ESKARIA Corp.. All rights reserved.
//

import Foundation

protocol NetworkServiceProtocol {
    func request<T: Codable>(baseUrl: String, requestModel: ESRequest, completionQueue: DispatchQueue, cachePolicy: URLRequest.CachePolicy, timeOut: TimeInterval, resultHandler: @escaping (Result<T, ESRequestError>) -> Void)
}
