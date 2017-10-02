//
//  ViewController.swift
//  MovieNight
//
//  Created by Angus Muller on 28/09/2017.
//  Copyright © 2017 Angus Muller. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var user1: User?
    var user2: User?
    

    override func viewDidLoad() {
        super.viewDidLoad()


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "aaab" {
            let VC = segue.destination as? PickGenreController
            VC?.delegate = self
        } else if segue.identifier == "pickMaxRunTime" {
        }
    }
    
    
    /*
    if let segueToPickGenre = segue.destination as? PickGenreController {
        segueToPickGenre.delegate = self
    } else if let segueToPickRuntime = segue.destination as? PickRuntimeController {
        segueToPickRuntime.delegate = self
    }
    */
    @IBAction func unwindToVC1(segue: UIStoryboardSegue) {
    
    }


}

extension ViewController: MovieGenreDelegate {
    
    func recordGenreSelected(user: Int, genre: Genre) {
        print("record genre started")
        if user == 1 {
            user1 = User(chosenGenre: genre)
            print(user1?.chosenGenre)
        } else {
            user2 = User(chosenGenre: genre)
            print(user2?.chosenGenre)
        }
    }
    
    func recordRuntimeSelected(user: Int, runtime: Runtime) {
        if user == 1 {
            user1?.maxRuntime = runtime
            print(user1?.maxRuntime)
        }
    }
    
}
