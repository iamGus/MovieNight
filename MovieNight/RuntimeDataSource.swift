//
//  RuntimeDataSource.swift
//  MovieNight
//
//  Created by Angus Muller on 02/10/2017.
//  Copyright © 2017 Angus Muller. All rights reserved.
//

import Foundation
import UIKit

class RuntimeDataSource: NSObject, UITableViewDataSource {
    
    private var data = RuntimeData.runtimeData
    
    override init() {
        super.init()
    }
    
    
    // Mark: - Data Source
    
    // Only one one section on view
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RuntimeCell", for: indexPath)
        
        let runtime = data[indexPath.row]
        cell.textLabel?.text = runtime.hoursInText
        
        return cell
    }
    
    // MARK: - Helper
    
    //NOTE CHECk I USE THIS - TO Pull OUT THE CHOSEN GENRE
    func runtime(at indexPath: IndexPath) -> Runtime {
        return data[indexPath.row]
    }
    
}
