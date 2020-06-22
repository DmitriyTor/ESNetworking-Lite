//
//  RequestModel.swift
//  
//
//  Created by Дмитрий Торопкин on 22.06.2020.
//

import Foundation

open class _RequestModel {
    
    var urlParameters = [String: Any]()
    
    var bodyParameters = [String: Any]()
    
    var headers = [ESHeader.content_type.rawValue: "application/json"]
}
