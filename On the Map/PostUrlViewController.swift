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


class PostUrlViewController: UIViewController, UITextFieldDelegate{
    
    
    var placeMark: CLPlacemark!
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var webUrlTextField: UITextField!
    
    @IBOutlet weak var submitButton: UIButton!
    
    
    
    //MARK: - lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        if self.placeMark != nil{
            addAnnotation()
        }else{
            println("No Placemark found..")
        }
        
        webUrlTextField.delegate = self
        
        //hide button
        submitButton.layer.cornerRadius = 5.0
        //        submitButton.hidden = true
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
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        submitButton.hidden = false
        return true
    }
    
    
    
    @IBAction func didSubmitClicked(sender: AnyObject) {
        
        //validate weblink
        
        //post weblink to parse
        var studentRequest = StudentLocationRequest(mapString: "\(placeMark.locality) \(placeMark.administrativeArea)", mediaUrl: webUrlTextField.text, latitude: placeMark.location.coordinate.latitude, longitude: placeMark.location.coordinate.longitude)
        
        ParseClient.sharedInstance().postStudentLocation(studentRequest, completionHandler: { (objectID, error) -> Void in
            
            //check for errors / success
            
            //this code runs in background thread, so anything UI should run on main thread.
            if(error != nil){
                //handle error.
                var errorMsg = error?.domain
                println("Error : \(errorMsg)")
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.displayAlert("Error :(", msg: errorMsg!)
                })
            }else{
                println("Success!")
                //self.displayAlert()
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    self.displayAlert("Success :)", msg: "Successfully posted.")
                    
                    var mapStr = "\(self.placeMark.locality) \(self.placeMark.administrativeArea)"
                    var studentInfo = StudentLocation(mediaUrl: self.webUrlTextField.text, location: self.placeMark.location.coordinate, mapString: mapStr)
                    
                    let app = UIApplication.sharedApplication().delegate as! AppDelegate
                    app.studentLocations.insert(studentInfo, atIndex: 0)
                })
                
            }
        })
    }
    
    
    
    func displayAlert(title:String, msg: String){
        //        self.navigationController?.dismissViewControllerAnimated(true, completion: nil)
        
        let alertView = UIAlertView(title: title, message: msg, delegate: nil, cancelButtonTitle: "OK")
        alertView.show()
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
