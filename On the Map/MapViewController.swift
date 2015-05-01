//
//  MapViewController.swift
//  On the Map
//
//  Created by Ashish Patel on 4/29/15.
//  Copyright (c) 2015 Average Techie. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController, MKMapViewDelegate {
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mapView.showsUserLocation = true
        mapView.delegate = self
        
        
        ParseClient.sharedInstance().getStudentLocations { (studentLocations, error) -> Void in
            if let stndLocations = studentLocations{
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.studentLocations = stndLocations
                self.addAnnotations()
            }
        }
        
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
                annotation.subtitle = "\(studentLocation.mediaUrl!)"
                annotation.coordinate = CLLocationCoordinate2D(latitude: studentLocation.latitude!, longitude: studentLocation.longitude!)
                mapView.addAnnotation(annotation)
                
            }
        }
    }
    
    
    // MARK: - mapview delegates
    
    let reuseId = "test"
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        
        if(annotation is MKUserLocation){
            //if annotation is not MKPointAnnotation then return nil so map draws default.
            return nil
        }
        
        var annotationView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
        
        if(annotationView == nil){
            
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            let button : UIButton = UIButton.buttonWithType(UIButtonType.DetailDisclosure) as! UIButton
            annotationView.rightCalloutAccessoryView = button
            //notice that only canShowCallout wont work unless we add button to annotationView
            annotationView.canShowCallout = true
            
        }else{
            annotationView.annotation = annotation
        }
        
        return annotationView
    }
    
    
    func mapView(mapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
        if let mediaUrl = view.annotation.subtitle{
            var url = NSURL(string: mediaUrl)
            UIApplication.sharedApplication().openURL(url!)
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
