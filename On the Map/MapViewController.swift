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
        
        ParseClient.sharedInstance().getStudentLocations { (studentLocations, error) -> Void in
            if let stndLocations = studentLocations{
                println("--- Recieved Response ----")
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.studentLocations = stndLocations
                self.addAnnotations()
            }
        }
        
        //addAnnotation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //add annotation on the map.
    func addAnnotations(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if let studentsLocations = appDelegate.studentLocations{
            for studentLocation: StudentLocation in studentsLocations{
                var annotation = MKPointAnnotation()
                annotation.title = "\(studentLocation.firstName!) \(studentLocation.lastName!)"
                annotation.coordinate = CLLocationCoordinate2D(latitude: studentLocation.latitude!, longitude: studentLocation.longitude!)
                mapView.addAnnotation(annotation)
                println("Adding")
            }
            println("--- Finished Response ----")
        }
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
