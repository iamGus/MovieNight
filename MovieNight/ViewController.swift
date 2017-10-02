//
//  ViewController.swift
//  MovieNight
//
//  Created by Angus Muller on 28/09/2017.
//  Copyright © 2017 Angus Muller. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // Outlets
    @IBOutlet weak var userButton1Label: UIButton!
    @IBOutlet weak var userButton2Label: UIButton!
    @IBOutlet weak var viewResultsButtonLabel: UIButton!
    
    // To store what Genre and Runtime user 1 and 2 select before searching for films
    var userSelection = UserSelectionDatasource()
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
// MARK: - Navigation
    
    // Set self as deligate for PickGenre controller.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let VC = segue.destination as? PickGenreController {
            VC.delegate = self
        } else {
            print("ERROR CODE")
        }
    }
    
    // Just so a unwide segue can be performed
    @IBAction func unwindToVC1(segue: UIStoryboardSegue) {
    
    }


}
// MARK: - Record user selection
extension ViewController: MovieGenreDelegate {
    
    // Record what Genre user 1 and 2 select
    func recordGenreSelected(user: User, genre: Genre) {
        userSelection.addGenre(user: user, genre: genre)
        checkStateOfSelection()
    }
    
    // Record what Runtime user 1 and 2 select
    func recordRuntimeSelected(user: User, runtime: Runtime) {
        userSelection.addRuntime(user: user, runtime: runtime)
        checkStateOfSelection()
    }
    
    // Checks the state for both users
    func checkStateOfSelection() {
        if userSelection.isUserReady(user: .user1) {
            userButton1Label.setImage(#imageLiteral(resourceName: "bubble-selected"), for: .normal)
        } else {
            // set user 1 not ready state
            userButton1Label.setImage(#imageLiteral(resourceName: "bubble-empty"), for: .normal)
        }
        
        if userSelection.isUserReady(user: .user2) {
            userButton2Label.setImage(#imageLiteral(resourceName: "bubble-selected"), for: .normal)
        } else {
            //set user 2 not ready
            userButton2Label.setImage(#imageLiteral(resourceName: "bubble-empty"), for: .normal)
        }
    }
    

    
}
