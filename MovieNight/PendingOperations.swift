//
//  PendingOperations.swift
//  MovieNight
//
//  Created by Angus Muller on 10/10/2017.
//  Copyright © 2017 Angus Muller. All rights reserved.
//

import Foundation

class PendingOperations {
    // Tracking each movie image operation with cell indexpath
    var downloadsInProgress = [IndexPath: Operation]()
    
    let downloadQueue = OperationQueue()
    
}
