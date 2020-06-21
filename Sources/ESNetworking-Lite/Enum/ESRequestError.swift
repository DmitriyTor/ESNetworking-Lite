//
//  ESRequestError.swift
//  ESNetworking-Lite
//
//  Created by Dmitriy on 21/06/2020.
//  Copyright © 2020 ESKARIA Corp.. All rights reserved.
//

import Foundation

enum ESRequestError: Error {
    case noConnection
    case lostConnection
    case unauthorized
    case internalServerError
    case badRequest
    case cancelled
    case timedOut
    case notFound
    case forbidden
    case unspecified(statusCode: Int)
    case dataDecodingError
}
