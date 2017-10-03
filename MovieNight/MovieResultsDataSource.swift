//
//  MovieResultsDataSource.swift
//  MovieNight
//
//  Created by Angus Muller on 03/10/2017.
//  Copyright © 2017 Angus Muller. All rights reserved.
//

import Foundation
import UIKit

class MovieResultsDataSource: NSObject, UITableViewDataSource {
    
    private var data = [Movie]()
    
    override init() {
        super.init()
    }
    
    func update(with movies: [Movie]) {
        data = movies
    }
    
    // Mark: - Data Source
    
    // Only one section on view
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath)
        
        let movie = data[indexPath.row]
        cell.textLabel?.text = movie.title
        
        return cell
    }
    
    // MARK: - Helper
    
    //Return movie data for just that selected row
    func genre(at indexPath: IndexPath) -> Movie {
        return data[indexPath.row]
    }
    
}
