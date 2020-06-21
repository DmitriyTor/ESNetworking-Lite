//
//  ESJSONCoder.swift
//  ESNetworking-Lite
//
//  Created by Dmitriy on 21/06/2020.
//  Copyright © 2020 ESKARIA Corp.. All rights reserved.
//

import Foundation

struct ESJSONCoder {
    private var decoder = JSONDecoder()
    private var encoder = JSONEncoder()
}

extension ESJSONCoder: ESJSONCoderProtocol {
    
    func encodeData<T>(data: T) -> (encodedModel: Data?, error: Error?) where T : Decodable, T : Encodable {
        if T.self is String.Type {
            return ("\(data)".data(using: .utf8), nil)
        } else {
            do {
                let encoded = try encoder.encode(data)
                return (encoded, nil)
            } catch {
                return (nil, error)
            }
        }
    }
    
    func decodedData<T: Decodable>(_ data: Data) -> (decodedModel: T?, error: Error?) {
        if T.self is String.Type {
            return (String(data: data, encoding: .utf8) as? T, nil)
        } else {
            do {
                let decoded = try decoder.decode(T.self, from: data)
                return (decoded, nil)
            } catch {
                return (nil, error)
            }
        }
    }
}
