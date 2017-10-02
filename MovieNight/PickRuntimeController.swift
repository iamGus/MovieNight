//
//  PickRuntimeController.swift
//  MovieNight
//
//  Created by Angus Muller on 29/09/2017.
//  Copyright © 2017 Angus Muller. All rights reserved.
//

import UIKit

protocol MovieRuntimeDelegate: class {
    func recordRuntimeSelectedFromV3(user: Int, runtime: Runtime)
}

class PickRuntimeController: UITableViewController {
    
    var chosenGenre: Genre?  //AM I using this?
    var dataSource = RuntimeDataSource()
    
    weak var delegate: MovieRuntimeDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
        tableView.separatorColor = UIColor(red: 240/255, green: 177/255, blue: 177/255, alpha: 1)

     
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
                //Send picked genre for that user to main view controller
                delegate?.recordRuntimeSelectedFromV3(user: 1, runtime: runtime)
                
            }
            
        }
    }
}
