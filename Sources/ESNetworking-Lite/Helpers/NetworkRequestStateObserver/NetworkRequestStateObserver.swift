//
//  File.swift
//  
//
//  Created by Дмитрий Торопкин on 23.06.2020.
//

import Foundation

import Foundation

final class NetworkRequestStateObserver {
    
    private var progressObservation: NSKeyValueObservation?
    
    init() {}
    
    deinit {
        progressObservation?.invalidate()
    }
}

extension NetworkRequestStateObserver: NetworkRequestStateObserverProtocol {
    
    func setObserverFor(task: URLSessionDataTask, progressHandler: ((Float) -> Void)?) {
        var progress: Float = 0
        progressObservation = task.progress.observe(\.fractionCompleted) { progressValue, _ in
            let currentProgress = Float(progressValue.fractionCompleted).rounded(toPlaces: 2)
            if !(progress == currentProgress) && !(progress > currentProgress) {
                progress = currentProgress
                progressHandler?(progress)
            }
        }
    }
}
