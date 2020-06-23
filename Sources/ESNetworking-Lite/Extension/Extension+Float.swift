//
//  Extension+Float.swift
//  ESNetworking-Lite
//
//  Created by Dmitriy on 22/06/2020.
//  Copyright © 2020 ESKARIA Corp.. All rights reserved.
//

import Foundation

extension Float {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> Float {
        let divisor = pow(10.0, Float(places))
        return (self * divisor).rounded() / divisor
    }
}
