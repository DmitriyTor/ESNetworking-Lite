//
//  ESJSONCoderProtocol.swift
//  ESNetworking-Lite
//
//  Created by Dmitriy on 21/06/2020.
//  Copyright © 2020 ESKARIA Corp.. All rights reserved.
//

import Foundation

protocol ESJSONCoderProtocol {
    
    func decodedData<T: Decodable>(_ data: Data) -> (decodedModel: T?, error: Error?)
    func encodeData<T: Codable>(data: T) -> (encodedModel: Data?, error: Error?)
}
