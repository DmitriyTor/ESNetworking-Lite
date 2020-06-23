//
//  File.swift
//  
//
//  Created by Дмитрий Торопкин on 23.06.2020.
//

import Foundation

protocol NetworkRequestStateObserverProtocol {
    func setObserverFor(task: URLSessionDataTask, progressHandler: ((Float) -> Void)?)
}
