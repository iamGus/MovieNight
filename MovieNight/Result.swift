//
//  Result.swift
//  MovieNight
//
//  Created by Angus Muller on 28/09/2017.
//  Copyright © 2017 Angus Muller. All rights reserved.
//

import Foundation

/// Results come through this enum allowing easy switch statement on success or failure.
enum Result<T, U> where U: Error {
    case success(T)
    case failure(U)
}
