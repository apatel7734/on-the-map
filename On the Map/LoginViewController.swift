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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func didLoginClicked(sender: AnyObject) {
        var errorString:String?
        
        if userNameTextField.text != "" && passwordTextField.text != ""{
            println("userName = \(userNameTextField.text) and password \(passwordTextField.text))")
            //            UdacityClient.sharedInstance().getSessionID(userNameTextField.text, password: passwordTextField.text)
            
            UdacityClient.sharedInstance().getSessionID(userNameTextField.text, password: passwordTextField.text, completionHandler: { (sessionID, error) -> Void in
                
                if(error != nil){
                    println("Error Login : \(error)")
                }else{
                    println("LoginSuccess = \(sessionID)")
                }
            })
            
            
        }else{
            println("userName and password field cannot be empty :)")
        }
        
    }
    
    @IBAction func didSignUpClicked(sender: AnyObject) {
        
    }
    
    
}

