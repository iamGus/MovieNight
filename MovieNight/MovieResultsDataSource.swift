//
//  MovieResultsDataSource.swift
//  MovieNight
//
//  Created by Angus Muller on 03/10/2017.
//  Copyright © 2017 Angus Muller. All rights reserved.
//

// Note: Currently if user goes back to do another search then I don't think the catch of images is released from memory. Can be additional feature for next update.


import Foundation
import UIKit

class MovieResultsDataSource: NSObject, UITableViewDataSource {
    
    private var movies = [Movie]()
    
    let pendingOperations = PendingOperations()
    let tableView: UITableView
    
    init(movies: [Movie], tableView: UITableView) {
        self.movies = movies
        self.tableView = tableView
        super.init()
    }
    
    
    // Mark: - Data Source
    
    // Only one section on view
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Define MovieCell class as reusable cell
        let movieCell = tableView.dequeueReusableCell(withIdentifier: MovieCell.reuseIdentifier, for: indexPath) as! MovieCell
        
        let movie = movies[indexPath.row]
        let viewModel = MovieCellViewModel(movie: movie) // Get viewmodel of cell
        
        movieCell.configure(with: viewModel) // pass viewmodel of cell to cell view
        
        if movie.artworkState == .placeholder {
            downloadArtworkForMovie(movie, atIndexPath: indexPath)
        }
        
        return movieCell
    }
    
    // MARK: - Helper
    
    //Return movie data for just that selected row
    func movie(at indexPath: IndexPath) -> Movie {
        return movies[indexPath.row]
    }
    
    func update(with movies: [Movie]) {
        self.movies = movies
    }
    
    func downloadArtworkForMovie(_ movie: Movie, atIndexPath indexPath: IndexPath) {
        //If Operation for that cell in already in progress then return
        if let _ = pendingOperations.downloadsInProgress[indexPath] {
            return
        }
        
        let downloader = ArtworkDownloader(movie: movie)
        
        // Run artwork downloader on completion block
        downloader.completionBlock = {
            if downloader.isCancelled {
                return
            }
            
            DispatchQueue.main.async {
                // Update pending operations class
                self.pendingOperations.downloadsInProgress.removeValue(forKey: indexPath)
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
        
        pendingOperations.downloadsInProgress[indexPath] = downloader
        pendingOperations.downloadQueue.addOperation(downloader)
        
    }
    
    //Below not used, possible enhancement to release memory for when Details view reloaded with new films, needs more research
    func wipeOperations() {
        pendingOperations.downloadsInProgress = [IndexPath: Operation]()
        pendingOperations.downloadQueue = OperationQueue()
    }
    
    
}
