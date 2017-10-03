//
//  PickRuntimeController.swift
//  MovieNight
//
//  Created by Angus Muller on 29/09/2017.
//  Copyright © 2017 Angus Muller. All rights reserved.
//

import UIKit

protocol MovieRuntimeDelegate: class {
    func recordRuntimeSelectedFromV3(user: User, runtime: Runtime)
}

class PickRuntimeController: UITableViewController {
    
    var dataSource = RuntimeDataSource()
    var currentUser: User = .noneSelected // Track which user currently using view
    
    weak var delegate: MovieRuntimeDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup tableview datasource and seperator colour
        tableView.dataSource = dataSource
        tableView.separatorColor = UIColor(red: 240/255, green: 177/255, blue: 177/255, alpha: 1)
    }
}

// MARK: - Navigation
extension PickRuntimeController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "unwindSegueToVC1", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "unwindSegueToVC1" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let runtime = dataSource.runtime(at: indexPath)
                //Send picked genre for that user to genre view controller
                delegate?.recordRuntimeSelectedFromV3(user: currentUser, runtime: runtime)
                
            } else {
                // Indexpath not unwrapped error
            }
        }
    }
}
