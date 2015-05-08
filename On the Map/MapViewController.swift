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
    
    var studentLocations = [StudentLocation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        mapView.showsUserLocation = true
        mapView.delegate = self
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        studentLocations = appDelegate.studentLocations!
        
        if studentLocations.isEmpty{
            refreshData()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //add annotation on the map.
    func addAnnotations(studentLocations: [StudentLocation]){
        if studentLocations.isEmpty{
            return
        }
        for studentLocation: StudentLocation in studentLocations{
            if(validateStudentLocation(studentLocation)){
                var annotation = MKPointAnnotation()
                annotation.title = "\(studentLocation.firstName!) \(studentLocation.lastName!)"
                annotation.subtitle = "\(studentLocation.mediaUrl!)"
                annotation.coordinate = CLLocationCoordinate2D(latitude: studentLocation.latitude!, longitude: studentLocation.longitude!)
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.mapView.addAnnotation(annotation)
                })
            }
            
        }
    }
    
    func validateStudentLocation(stdntLoc: StudentLocation) -> Bool{
        var counter = 0
        
        if let firstName = stdntLoc.firstName{
            counter++
        }
        
        if let lastName = stdntLoc.lastName{
            counter++
        }
        
        if let url = stdntLoc.mediaUrl{
            counter++
        }
        
        if (stdntLoc.latitude != nil && stdntLoc.longitude != nil){
            counter++
        }
        return counter == 4
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
    
    
    func refreshData(){
        ParseClient.sharedInstance().getStudentLocations {(returnedStudentLocations, error) -> Void in
            if let err = error{
                var msg = err.domain
                UIAlertView(title: "Error getting student info!", message: msg, delegate: nil, cancelButtonTitle: "OK")
            }else if let stndLocations = returnedStudentLocations{
                let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
                appDelegate.studentLocations = stndLocations
                self.addAnnotations(stndLocations)
            }
        }
    }
    
    
    @IBAction func didRefreshStudentLocationClicked(sender: AnyObject) {
        refreshData()
    }
    
    
    
    @IBAction func didInformationPostClicked(sender: AnyObject) {
        
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
