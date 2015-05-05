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
    func getSessionID(userName: String, password: String,completionHandler: (udaSession: UdacitySession?, error: NSError?) -> Void){
        var url = NSURL(string: Constants.BASE_URL+Methods.SESSION)!
        
        //step.1 make request from URL
        let request = NSMutableURLRequest(URL: url)
        
        //step.2 define values required for request.
        request.HTTPMethod = Methods.POST
        request.addValue(Parameters.APPLICATION_JSON, forHTTPHeaderField: Parameters.ACCEPT)
        request.addValue(Parameters.APPLICATION_JSON, forHTTPHeaderField: Parameters.CONTENT_TYPE)
        
        var bodyString = "{\"udacity\": {\"username\": \"\(userName)\", \"password\": \"\(password)\"}}"
        
        request.HTTPBody = bodyString.dataUsingEncoding(NSUTF8StringEncoding)
        
        //step.3 create session.
        let session = NSURLSession.sharedSession()
        
        //step.4 create request.
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
                    completionHandler(udaSession: nil, error: error)
                }else{
                    var jsonResponse:NSDictionary = result as! NSDictionary
                    var udaSession = UdacitySession(jsonDict: jsonResponse)
                    
                    if udaSession.status != nil{
                        completionHandler(udaSession: nil, error: NSError(domain: udaSession.errorMsg!, code: udaSession.status!, userInfo: nil))
                    }else{
                        completionHandler(udaSession: udaSession, error: nil)
                    }
                }
            })
            
        })
        
        //step.5 make network request
        task.resume()
    }
    
    
    class func sharedInstance() -> UdacityClient{
        struct Singleton{
            static var singletonUdacityClient = UdacityClient()
        }
        return Singleton.singletonUdacityClient
    }
}
