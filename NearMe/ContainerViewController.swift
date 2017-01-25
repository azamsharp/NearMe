//
//  ContainerViewController.swift
//  NearMe
//
//  Created by Mohammad Azam on 1/24/17.
//  Copyright © 2017 Mohammad Azam. All rights reserved.
//

import UIKit
import MapKit

class ContainerViewController: UIViewController, MapsViewControllerDelegate {

    @IBOutlet weak var topConstraint :NSLayoutConstraint!
    
    var place :Place!
    var mapsViewController :MapsViewController!
    var mapsDetailsViewController :MapViewDetailsTableViewController!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.topConstraint.constant = self.view.frame.size.height
        
        self.mapsViewController = self.childViewControllers.first as! MapsViewController
        self.mapsDetailsViewController = self.childViewControllers.last as! MapViewDetailsTableViewController
        
        mapsViewController.delegate = self
        self.mapsViewController.place = self.place
        self.title = place.title
    }
    
    func mapsViewControllerDidSelectAnnotation(mapItem: MKMapItem) {
        
        self.topConstraint.constant = self.view.frame.size.height
        
        UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 10.0, options: .curveEaseIn, animations: { 
            
            self.view.layoutIfNeeded()
            
        }) { (true) in
            
            self.topConstraint.constant = self.view.frame.size.height - 100
            
            UIView.animate(withDuration: 1.0, delay: 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 10.0, options: .curveEaseIn, animations: { 
                self.view.layoutIfNeeded()
            }, completion: nil)
            
            
        }
        
        
        self.mapsDetailsViewController.mapItem = mapItem
        self.mapsDetailsViewController.configure()
    }

}
