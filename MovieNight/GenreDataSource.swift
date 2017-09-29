//
//  GenreDataSource.swift
//  MovieNight
//
//  Created by Angus Muller on 29/09/2017.
//  Copyright © 2017 Angus Muller. All rights reserved.
//

import Foundation
import UIKit

class GenreDataSource: NSObject, UITableViewDataSource {
    
    private var data = [Genre]()
    
    override init() {
        super.init()
    }
    
    func update(with genres: [Genre]) {
        data = genres
    }
    
    // Mark: - Data Source
    
    // Only one one section on view
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GenreCell", for: indexPath)
        
        let genre = data[indexPath.row]
        cell.textLabel?.text = genre.name
        
        return cell
    }
    
    // MARK: - Helper
    
    //NOTE CHECk I USE THIS - TO Pull OUT THE CHOSEN GENRE
    func genre(at indexPath: IndexPath) -> Genre {
        return data[indexPath.row]
    }
    
}
