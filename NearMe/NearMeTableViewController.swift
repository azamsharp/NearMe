//
//  NearMeTableViewController.swift
//  NearMe
//
//  Created by Mohammad Azam on 1/24/17.
//  Copyright © 2017 Mohammad Azam. All rights reserved.
//

import Foundation
import UIKit

class NearMeTableViewController : UITableViewController {
    
    var categoryPlaces = ["Banks","Bars","Coffee Shops","Gas Stations","Restaurants","Fast Food","Attractions","Gas Stations","Hotels","Hospitals","Movies"]
    
    var places = [Place]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        populatepuCategoriesForPlaces()
        self.tableView.reloadData()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.places.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NearMeTableViewCell", for: indexPath) as! NearMeTableViewCell
        
        let place = self.places[indexPath.row]
        
        cell.titleLabel.text = place.title
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let indexPath = self.tableView.indexPathForSelectedRow else {
            fatalError("No row selected")
        }
        
        let place = self.places[indexPath.row]
        let containerViewController = segue.destination as! ContainerViewController
    
        containerViewController.place = place
    }
    
    private func populatepuCategoriesForPlaces() {
        
        for category in categoryPlaces {
            
            let place = Place()
            place.title = category
            
            self.places.append(place)
        }
        
    }
    
    
    
}
