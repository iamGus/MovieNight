//
//  MovieResultsViewController.swift
//  MovieNight
//
//  Created by Angus Muller on 03/10/2017.
//  Copyright © 2017 Angus Muller. All rights reserved.
//

import UIKit

class MovieResultsViewController: UITableViewController {
    
    var userSelection = UserSelectionDatasource()
    let dataSource = MovieResultsDataSource()
    let client = TMDbClient()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up tableview dtasource and seperator colour
        tableView.dataSource = dataSource
        tableView.separatorColor = UIColor(red: 240/255, green: 177/255, blue: 177/255, alpha: 1)
        
        //ERROR LOGIC INCASE USER DATA DID NOT GET SENT?
        
        // Get Movie results from tmdb and update datasource
        client.getMovieSuggestions(sortBy: .popularityDesc, genres: userSelection.chosenGenres(), runtimeGreater: 59, runTimeLess: userSelection.averageMaxRuntime(), page: 1) { [weak self] result in
            switch result {
            case .success(let movies):
                self?.dataSource.update(with: movies)
                self?.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
        
    }


}
