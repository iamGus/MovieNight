//
//  MovieCellViewModel.swift
//  MovieNight
//
//  Created by Angus Muller on 05/10/2017.
//  Copyright © 2017 Angus Muller. All rights reserved.
//

import Foundation
import UIKit

struct MovieCellViewModel {
    let image: UIImage
    let title: String
    let avereageVote: String
}

extension MovieCellViewModel {
    init(movie: Movie) {
        // If movie artwork state marked as downloaded then use movie artwork UIimage property, otherwise use placeholder
        self.image = movie.artworkState == .downloaded ? movie.artwork! : #imageLiteral(resourceName: "moviePlaceholder")
        self.title = movie.title
        self.avereageVote = String(movie.averageVote)
        
    }
}
