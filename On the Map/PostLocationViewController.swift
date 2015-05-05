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
    
    //MARK: - lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationTextField.delegate = self
        // Do any additional setup after loading the view.
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
        //validate input
        if !validateLocationText(){
            alertUser("Must provide location for post.", alertTitle: "Missing location text.")
        }
        //reverse geocode location
        var geocoder = CLGeocoder()
        geocoder.geocodeAddressString(locationTextField.text, completionHandler: { (locations, error) -> Void in
            
            //validate location
            if let locationError:NSError = error as NSError!{
                self.alertUser(locationError.description, alertTitle: "Geocoding Error!")
            }
            
            //present url link controller
            var locSize = locations.count

            if(locSize > 0){
                if let placeMark: CLPlacemark = locations?[0] as? CLPlacemark{
                    let postUrlVC  = self.storyboard?.instantiateViewControllerWithIdentifier("urlviewcontroller") as!
                    PostUrlViewController
                    postUrlVC.placeMark = placeMark
                    self.presentViewController(postUrlVC, animated: true, completion: nil)
                }
            }
        })
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
    
    
    
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
