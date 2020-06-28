//
//  _RequestModel.swift
//  ESNetworking-Lite
//
//  Created by Dmitriy on 22/06/2020.
//  Copyright © 2020 ESKARIA Corp.. All rights reserved.
//

import Foundation

open class _RequestModel {
    
    public init() {}
    
    open var urlParameters: [String: Any] {
        return [String: Any]()
    }
    
    open var bodyParameters: [String: Any] {
        return [String: Any]()
    }
    
    open var headers: [String: String] {
        return [
            ESHeader.content_type.rawValue: "application/json",
            ESHeader.accept_encoding.rawValue: ""
        ]
    }
}
