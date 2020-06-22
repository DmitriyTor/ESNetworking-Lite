//
//  RequestModel.swift
//  
//
//  Created by Дмитрий Торопкин on 22.06.2020.
//

import Foundation

open class _RequestModel {
    
    open var urlParameters = [String: Any]()
    
    open var bodyParameters = [String: Any]()
    
    open var headers = [ESHeader.content_type.rawValue: "application/json"]
}
