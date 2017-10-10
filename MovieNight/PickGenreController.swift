//
//  PickGenreController.swift
//  MovieNight
//
//  Created by Angus Muller on 29/09/2017.
//  Copyright © 2017 Angus Muller. All rights reserved.
//

import UIKit

protocol MovieGenreDelegate: class {
    func recordGenreSelected(user: User, genre: Genre)
    func recordRuntimeSelected(user: User, runtime: Runtime)
}

class PickGenreController: UITableViewController {
    
    let dataSource = GenreDataSource()
    let client = TMDbClient()
    var currentUser: User = .noneSelected // Track which user currently using view
    
    weak var delegate: MovieGenreDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up tableview datasource and seperator colour
        tableView.dataSource = dataSource
        tableView.separatorColor = UIColor(red: 240/255, green: 177/255, blue: 177/255, alpha: 1)
        
        // Get Genre data from tmdb and update datasource
        client.getGenre() { [weak self] result in
            switch result {
            case .success(let genres):
                self?.dataSource.update(with: genres) // update datasource
                self?.tableView.reloadData() // Reload table data
            case.failure(let error):
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


// MARK: - Navigation and Delegates

// Navigate to PickRuntimeController when a Genre is selected
extension PickGenreController: MovieRuntimeDelegate {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "pickMaxRunTime", sender: nil)
    }
    
    //Set Runtime Delegate to self and inform main Viewcotroller Genre selected
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pickMaxRunTime" {
            if let indexPath = tableView.indexPathForSelectedRow {
                if let pickRuntimeViewController = segue.destination as? PickRuntimeController {
                    let genre = dataSource.genre(at: indexPath)
                    
                    //Set Runtime Delefate to self
                    pickRuntimeViewController.delegate = self
                    
                    //Tell pickRuntimeViewController which user is currently selected
                    pickRuntimeViewController.currentUser = currentUser
                    
                    //Send picked genre for that user to main view controller
                    delegate?.recordGenreSelected(user: currentUser, genre: genre)
                } else {
                    // COULD NOT DETECT PICKRUNTIMECONTROLLER ERROR
                }
            
            } else {
                // COULD NOT GET SELECTED ROW ERROR
            }
            
        }
    }
    

    // Gets Runtime from PickRuntimeController and sends data to main viewcontroller
    func recordRuntimeSelectedFromV3(user: User, runtime: Runtime) {
    delegate?.recordRuntimeSelected(user: user, runtime: runtime)
    }
    
    
    // Generic alert pop up function used for all error handling notifications
    func showAlert(title: String, message: String, style: UIAlertControllerStyle = .alert) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
}
