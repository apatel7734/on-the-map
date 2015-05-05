//
//  PostUrlViewController.swift
//  On the Map
//
//  Created by Ashish Patel on 5/2/15.
//  Copyright (c) 2015 Average Techie. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit


class PostUrlViewController: UIViewController {
    
    
    var placeMark: CLPlacemark!
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var webUrlTextField: UITextField!
    
    
    //MARK: - lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        addAnnotation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func didCloseClicked(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func addAnnotation(){
        var annotation = MKPointAnnotation()
        annotation.title = "\(placeMark.locality) \(placeMark.administrativeArea)"
        annotation.coordinate = placeMark.location.coordinate
        mapView.addAnnotation(annotation)
        
        //mark center of the map on the screen.
        mapView.centerCoordinate = placeMark.location.coordinate
        
        //zoom to locatin
        let region = MKCoordinateRegionMakeWithDistance(placeMark.location.coordinate, 10000, 10000)
        mapView.setRegion(region, animated: true)
    }
    
    
    @IBAction func didSubmitClicked(sender: AnyObject) {
        //validate weblink
        
        //post weblink to parse
        var studentRequest = StudentLocationRequest(mapString: "\(placeMark.locality) \(placeMark.administrativeArea)", mediaUrl: webUrlTextField.text, latitude: placeMark.location.coordinate.latitude, longitude: placeMark.location.coordinate.longitude)
        
        ParseClient.sharedInstance().postStudentLocation(studentRequest, completionHandler: { (objectID, error) -> Void in
            
            //check for errors / success
            if(error != nil){
                //handle error.
                var errorMsg = error?.domain
                UIAlertView(title: "Error while posting!", message: errorMsg, delegate: nil, cancelButtonTitle: "Ok").show()
            }else{
                //handle success response
                UIAlertView(title: "Success!", message: nil, delegate: nil, cancelButtonTitle: "Ok").show()
            }
        })
        
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
