//
//  RequestModel.swift
//  
//
//  Created by Дмитрий Торопкин on 22.06.2020.
//

import Foundation

open class _RequestModel {
    
    open var urlParameters: [String: Any] {
        return [String: Any]()
    }
    
    open var bodyParameters: [String: Any] {
        return [String: Any]()
    }
    
    open var headers: [String: String] {
        return [
            ESHeader.content_type.rawValue: "application/json"
        ]
    }
}
