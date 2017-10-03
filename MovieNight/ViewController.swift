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
    
    // Record which user currently selected for choices, note this is only being passed to other view controllers, other controllers then return selected user info with genre and runtime info. As we already know who is seected with this property is that needed? Modification could be to not pass back current user selected bu use this property with the selection datasource methods.
    var currentUser: User = .noneSelected
    

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
// MARK: - Navigation
    
    // Set current user selected depending on which user button pressed.
    @IBAction func UserSelectionButtons(_ sender: UIButton) {
        if sender == userButton1Label {
            currentUser = .user1
        } else {
            currentUser = .user2
        }
    }
    
    
    // Set self as deligate for PickGenre controller.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let pickGenreViewController = segue.destination as? PickGenreController {
            pickGenreViewController.delegate = self
            pickGenreViewController.currentUser = currentUser
            print(currentUser)
        } else if let movieResultsViewController = segue.destination as? MovieResultsViewController {
            if userSelection.areUsersReady() == true {
               movieResultsViewController.userSelection = userSelection
            } else {
                showAlert(title: "Alert", message: "Please make sure both users have made a selection")
            }
            
        } else {
            // If let to view contoller did not work
        }
    }
    
    // Just so a unwide segue can be performed
    @IBAction func unwindToVC1(segue: UIStoryboardSegue) {
    
    }
    
    // Clear user selection
    @IBAction func ClearSelectionButton(_ sender: Any) {
        currentUser = .noneSelected
        userSelection.resetUsers() // Reset stored selction properties to nil
        setStateOfSelection() // Set buttons back to empty
    }
    

}
// MARK: - User selection
extension ViewController: MovieGenreDelegate {
    
    // Record what Genre user 1 and 2 select
    func recordGenreSelected(user: User, genre: Genre) { // Called from GenreController
        userSelection.addGenre(user: user, genre: genre)
        setStateOfSelection()
    }
    
    // Record what Runtime user 1 and 2 select
    func recordRuntimeSelected(user: User, runtime: Runtime) { // Called from GenreController
        userSelection.addRuntime(user: user, runtime: runtime)
        setStateOfSelection()
    }
    
    // Checks the state for both users, make appropriate changes
    func setStateOfSelection() {
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
    
    // Generic alert pop up function used for all error handling notifications
    func showAlert(title: String, message: String, style: UIAlertControllerStyle = .alert) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        
        let okAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }

    
}
