//
//  ArtworkDownloader.swift
//  MovieNight
//
//  Created by Angus Muller on 10/10/2017.
//  Copyright © 2017 Angus Muller. All rights reserved.
//

import Foundation
import UIKit

class ArtworkDownloader: Operation {
    let movie: Movie
    
    init(movie: Movie) {
        self.movie = movie
        super.init()
    }
    
    override func main() {
        if self.isCancelled {
            return
        }
        
        // Check can convert url string to URL
        guard let url = URL(string: movie.artworkUrl) else {
            return
        }
        
        do {
            let imageData = try Data(contentsOf: url)
            
            if self.isCancelled {
                return
            }
            
            // If image data has data and can be put into type of UIImage
            if imageData.count > 0 && (UIImage(data: imageData) != nil) {
                movie.artwork = UIImage(data: imageData)
                movie.artworkState = .downloaded
            // If this does not work then mark as failed
            } else {
                movie.artworkState = .failed
            }
            
        } catch let error {
            movie.artworkState = .failed
            print("image error catch: \(error)")
            return
        }
    }
    
}
