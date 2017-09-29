//
//  ViewController.swift
//  MovieNight
//
//  Created by Angus Muller on 28/09/2017.
//  Copyright © 2017 Angus Muller. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var client = TMDbClient()
    
    var storeGnre = [Genre]()
    var coupleOfCats = [Genre]()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //let someGenre = [Genre(id: 35, name: "Comady"), Genre(id: 12, name: "Adventure")]
        
        //let endpoint = TMDb.dicover(sortBy: .revenueAsc, genres: someGenre, runtimeGreater: 60, runtimeLess: 160, page: 1)
        //let request = endpoint.request
        //print(request)
        
        client.getGenre() { [weak self] result in
            switch result {
            case .success(let genres):
                for each in genres {
                    print("\(each.id), \(each.name)")
                    self?.storeGnre.append(each)
                }
                self?.coupleOfCats = [(self?.storeGnre[0])!, (self?.storeGnre[5])!]
                self?.getMovieNow()
            case.failure(let error):
                print(error)
            }
        }
        

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getMovieNow() {
        client.getMovieSuggestions(sortBy: .popularityDesc, genres: coupleOfCats, runtimeGreater: 80, runTimeLess: 180, page: 1) { result in
            switch result {
            case .success(let movies):
                for each in movies {
                    print("Film name: \(each.title), Vote: \(each.averageVote)")
                }
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    
    

}

