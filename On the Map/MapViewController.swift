//
//  MapViewController.swift
//  On the Map
//
//  Created by Ashish Patel on 4/29/15.
//  Copyright (c) 2015 Average Techie. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    
    
    @IBOutlet weak var mapView: MKMapView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mapView.showsUserLocation = true
        
        addAnnotation()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //add annotation on the map.
    func addAnnotation(){
        var annotation = MKPointAnnotation()
        annotation.title = "Another Location"
        annotation.coordinate = CLLocationCoordinate2D(latitude: 21.283921, longitude: -157.831661)
        mapView.addAnnotation(annotation)
        mapView.centerCoordinate = annotation.coordinate
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
