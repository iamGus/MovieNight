//
//  PickGenreController.swift
//  MovieNight
//
//  Created by Angus Muller on 29/09/2017.
//  Copyright © 2017 Angus Muller. All rights reserved.
//

import UIKit

protocol MovieGenreDelegate: class {
    func recordGenreSelected(user: Int, genre: Genre)
    func recordRuntimeSelected(user: Int, runtime: Runtime)
}

class PickGenreController: UITableViewController {
    
    let dataSource = GenreDataSource()
    let client = TMDbClient()
    
    weak var delegate: MovieGenreDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
        tableView.separatorColor = UIColor(red: 240/255, green: 177/255, blue: 177/255, alpha: 1)
        //definesPresentationContext = true
        
        
        client.getGenre() { [weak self] result in
            switch result {
            case .success(let genres):
                self?.dataSource.update(with: genres)
                self?.tableView.reloadData()
            case.failure(let error):
                print(error)
            }
        }

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

}

// To make delegate func to send array of downladoed genre to main viewconroller




// MARK: - Navigation
extension PickGenreController: MovieRuntimeDelegate {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "pickMaxRunTime", sender: nil)
    }
    
    //NO ELSE CLAUSE IN
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pickMaxRunTime" {
            if let indexPath = tableView.indexPathForSelectedRow {
                if let pickRuntimeViewController = segue.destination as? PickRuntimeController {
                    let genre = dataSource.genre(at: indexPath)
                    pickRuntimeViewController.delegate = self
                    //Send picked genre for that user to main view controller
                    delegate?.recordGenreSelected(user: 1, genre: genre)
                    print("should have just sent data \(genre.name)")
                }
            
            }
            
        }
    }
    
    func recordRuntimeSelectedFromV3(user: Int, runtime: Runtime) {
    delegate?.recordRuntimeSelected(user: user, runtime: runtime)
    }
}
