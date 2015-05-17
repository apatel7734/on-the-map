//
//  PostLocationViewController.swift
//  On the Map
//
//  Created by Ashish Patel on 5/2/15.
//  Copyright (c) 2015 Average Techie. All rights reserved.
//

import UIKit
import CoreLocation

class PostLocationViewController: UIViewController, UITextFieldDelegate{
    
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var locationTextField: UITextField!
    
    @IBOutlet weak var findLocationButton: UIButton!
    
    @IBOutlet weak var progressIndicator: UIActivityIndicatorView!
    
    var placeMark: CLPlacemark?
    
    //MARK: - lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationTextField.delegate = self
        // Do any additional setup after loading the view.
        findLocationButton.layer.cornerRadius = 5.0
    }
    
    override func viewWillAppear(animated: Bool) {
        hideProgressIndicator()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //MARK: - locationTextField delegates
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    //MARK: - IBActions
    @IBAction func didFindLocationClicked(sender: AnyObject) {
        
        showProgressIndicator()
        
        //validate input
        if !validateLocationText(){
            self.hideProgressIndicator()
            alertUser("Must provide location for post.", alertTitle: "Missing location text.")
        }
        
        //reverse geocode location
        var geocoder = CLGeocoder()
        geocoder.geocodeAddressString(locationTextField.text, completionHandler: { (locations, error) -> Void in
            
            //validate location
            if let locationError:NSError = error as NSError!{
                self.hideProgressIndicator()
                self.alertUser("Error finding location :(", alertTitle: "Geocoding Error!")
                return
            }
            
            if(locations == nil){
                self.hideProgressIndicator()
                self.alertUser("Please check string you've provided.", alertTitle: "Zero locations found")
                return
            }
            
            
            //present url link controller
            var locSize = locations.count
            
            if(locSize > 0){
                if let placeMark: CLPlacemark = locations?[0] as? CLPlacemark{
                    if(placeMark.locality == nil || placeMark.administrativeArea == nil){
                        self.hideProgressIndicator()
                        self.alertUser("Please check string you've provided.", alertTitle: "City OR State couldnot be found.")
                    }else{
                        self.placeMark = placeMark
                        self.performSegueWithIdentifier("weburlPushSegue", sender: self)
                    }
                    
                }
            }
        })
    }
    
    
    func hideProgressIndicator(){
        progressIndicator.hidden = true
    }
    
    func showProgressIndicator(){
        progressIndicator.hidden = false
    }
    
    
    func alertUser(alertMsg: String, alertTitle: String){
        UIAlertView(title: alertTitle, message: alertMsg, delegate: nil, cancelButtonTitle: "OK").show()
    }
    
    
    func validateLocationText() -> Bool{
        if locationTextField.text.isEmpty{
            return false
        }else{
            return true
        }
    }
    
    
    @IBAction func didCloseClicked(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if(segue.identifier == "weburlPushSegue"){
            let postUrlVC =  segue.destinationViewController as! PostUrlViewController
            postUrlVC.placeMark = self.placeMark
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    
}
