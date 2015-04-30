//
//  UdacityClient.swift
//  On the Map
//
//  Created by Ashish Patel on 4/26/15.
//  Copyright (c) 2015 Average Techie. All rights reserved.
//

import Foundation

class UdacityClient: NetworkClient {
    
    
    /*
    * call network to get sessionID .
    */
    func getSessionID(userName: String, password: String,completionHandler: (sessionID: String?, error: NSError?) -> Void){
        var url = NSURL(string: Constants.BASE_URL+Methods.SESSION)!
        println("Url = \(url)")
        
        //step.1 make request from URL
        let request = NSMutableURLRequest(URL: url)
        
        //step.2 define values required for request.
        request.HTTPMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        var bodyString = "{\"udacity\": {\"username\": \"\(userName)\", \"password\": \"\(password)\"}}"
        request.HTTPBody = bodyString.dataUsingEncoding(NSUTF8StringEncoding)
        
        //step.3 create session.
        let session = NSURLSession.sharedSession()
        
        //step.4 make create request.
        let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, error) -> Void in
            
            //step.6 handle error.
            if error != nil{
                //we got an error, handle it here.
            }
            // subset response data by ignoring first 5 characters
            let newData = data.subdataWithRange(NSMakeRange(5, data.length))
            
            //step.7 handle response and parsing.
            println(NSString(data: newData, encoding: NSUTF8StringEncoding))
            
            self.parseJson(newData, completionHandler: { (result, error) -> Void in
                if(error != nil){
                    completionHandler(sessionID: nil, error: error)
                }else{
                    let error: String? = result?.valueForKey("error") as? String
                    
                    if error != nil{
                        let code: Int? = result?.valueForKey("status") as? Int
                        
                        completionHandler(sessionID: nil, error: NSError(domain: error!, code: code!, userInfo: nil))
                    }else{
                        
                        let account: NSDictionary = result?.valueForKey("account") as! NSDictionary
                        let keyVal: AnyObject? = account.valueForKey("key")
                        
                        let session: NSDictionary = result?.valueForKey("session") as! NSDictionary
                        let sessionID:String = session.valueForKey("id") as! String
                        //println("sessionID = \(sessionID)")
                        completionHandler(sessionID: sessionID, error: nil)
                    }
                }
                
            })
            
        })
        
        //step.5 make request
        task.resume()   
    }
    
    
    class func sharedInstance() -> UdacityClient{
        struct Singleton{
            static var singletonUdacityClient = UdacityClient()
        }
        return Singleton.singletonUdacityClient
    }
}
