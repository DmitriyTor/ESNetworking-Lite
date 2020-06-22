//
//  _RequestModelProtocol.swift
//  ESNetworking-Lite
//
//  Created by Dmitriy on 22/06/2020.
//  Copyright © 2020 ESKARIA Corp.. All rights reserved.
//

import Foundation

public protocol _RequestModelProtocol {
    
    var path: String { get }
    var method: ESRequestType { get }
}
