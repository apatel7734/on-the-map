//
//  LoginViewController.swift
//  On the Map
//
//  Created by Ashish Patel on 4/25/15.
//  Copyright (c) 2015 Average Techie. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var userNameTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loadingView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        userNameTextField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSForegroundColorAttributeName: UIColor.whiteColor()])
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSForegroundColorAttributeName: UIColor.whiteColor()])

        loadingView.layer.cornerRadius = 5.0
        loadingView.hidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didLoginClicked(sender: AnyObject) {
        var errorString:String?
        
        //check network availability
        if(!NetworkClient.hasConnectivity()){
            UIAlertView(title: "No network.", message: "Please check you network from settings." , delegate: nil, cancelButtonTitle: "OK").show()
            return
        }
        
        //validate input.
        if(validateInput()){
            
            loadingView.hidden = false

            //get sessionID from Udacity.
            UdacityClient.sharedInstance().getSessionID(userNameTextField.text, password: passwordTextField.text, completionHandler: { (udacitySession, error) -> Void in
                
                if(error != nil){
                    //error in login, display message to the user.
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.loadingView.hidden = true
                        self.displayUIAlert("Login Error.", msg: error!.domain)
                    })
                    
                }else{
                    //save session for future use.
                    var appDel = UIApplication.sharedApplication().delegate as! AppDelegate
                    appDel.loginUdacitySesison = udacitySession
                    //successfully logged in. go to next screen.
                    
                    dispatch_async(dispatch_get_main_queue(), { () -> Void in
                        self.loadingView.hidden = true
                        self.performSegueWithIdentifier("modaltabbarsegue", sender: self)
                    })
                }
            })
        }else{
            //present userwith error.
            self.displayUIAlert("Missing information!", msg: "Must provide username and password to login.")
        }
    }
    
    func validateInput() -> Bool{
        if userNameTextField.text.isEmpty || passwordTextField.text.isEmpty{
            return false
        }
        return true
    }
    
    @IBAction func didSignUpClicked(sender: AnyObject) {
     var urlString = NSURL(string: "https://www.udacity.com/account/auth#!/signin")
        UIApplication.sharedApplication().openURL(urlString!)
    }
    
    
    func displayUIAlert(title: String, msg: String){
        UIAlertView(title: title, message: msg, delegate: nil, cancelButtonTitle: "Ok").show()
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //add information to destination view controller here.
    }
    
    
}

