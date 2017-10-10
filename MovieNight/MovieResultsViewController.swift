//
//  MovieResultsViewController.swift
//  MovieNight
//
//  Created by Angus Muller on 03/10/2017.
//  Copyright © 2017 Angus Muller. All rights reserved.
//

import UIKit

class MovieResultsViewController: UITableViewController {
    
    struct Constants {
        static let albumCellHeight: CGFloat = 80
    }
    
    var userSelection = UserSelectionDatasource()
    
    lazy var dataSource: MovieResultsDataSource = {
        return MovieResultsDataSource(movies: [], tableView: self.tableView)
    }()
    
    
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
                switch error {
                case .requestFailed: self?.showAlert(title: "Alert", message: "No network connection, please try again later")
                case .responseUnsuccessful: print("\(APIError.responseUnsuccessful.errorDescription)")
                case .invalidData: print("\(APIError.invalidData.errorDescription)")
                case .jsonConversionFailure: print("\(APIError.jsonConversionFailure.errorDescription)")
                case .jsonParsingFailure: print("\(APIError.jsonParsingFailure.errorDescription)")
                }
            }
        }
        
    }
}

extension MovieResultsViewController {
    
    // MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.albumCellHeight
    }
    
    
    // MARK: - Notifications
    
    // Generic alert pop up function used for all error handling notifications
    func showAlert(title: String, message: String, style: UIAlertControllerStyle = .alert) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
