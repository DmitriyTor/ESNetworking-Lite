//
//  File.swift
//  
//
//  Created by Дмитрий Торопкин on 22.06.2020.
//

import Foundation

public protocol _RequestModelProtocol {
    
    var path: String { get }
    var method: ESRequestType { get }
    var urlParameters: [String: Any] { get }
    var bodyParameters: [String: Any] { get }
    var headers: [String: String] { get }
}
