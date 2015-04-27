//
//  UdacityClient.swift
//  On the Map
//
//  Created by Ashish Patel on 4/26/15.
//  Copyright (c) 2015 Average Techie. All rights reserved.
//

import Foundation

class UdacityClient: NSObject {
    
    
    func getSessionID(userName: String, password: String){
        //step.1 make request from URL
        let request = NSMutableURLRequest(URL: NSURL(string: Constants.BASE_URL+Methods.SESSION)!)
        //step.2 define values required for request.
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.HTTPBody = "{\"udacity\": {\"username\": \"\(userName)\", \"password\": \"\(password)\"}}".dataUsingEncoding(NSUTF8StringEncoding)
        //step.3 create session.
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            if error != nil{
                //we got an error, handle it here.
            }
            // subset response data by ignoring first 5 characters
            let newData = data.subdataWithRange(NSMakeRange(5, data.length))
            println("Data = \(newData)")
        })
        
        task.resume()
        
        
    }
    
    
    class func sharedInstance() -> UdacityClient{
        struct Singleton{
            static var singletonUdacityClient = UdacityClient()
        }
        return Singleton.singletonUdacityClient
    }
}
