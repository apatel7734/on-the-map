//
//  ParseClient.swift
//  On the Map
//
//  Created by Ashish Patel on 4/29/15.
//  Copyright (c) 2015 Average Techie. All rights reserved.
//

import Foundation

class ParseClient: NetworkClient {
    
    func getStudentLocations(){
        
        let parameters = [Parameters.LIMIT : 100]
        
        var urlString = Constants.BASE_URL + Methods.STUDENT_LOCATION  + escapedParameters(parameters)
        let url = NSURL(string: urlString)
        
        //step.1 create request
        let request = NSMutableURLRequest(URL: url!)
        
        //step.2 add request values
        request.HTTPMethod = "GET"
        
        request.addValue(Constants.APPLICATION_ID, forHTTPHeaderField: "X-Parse-Application-Id")
        request.addValue(Constants.REST_API_KEY, forHTTPHeaderField: "X-Parse-REST-API-Key")
        
        
        //setp.3 get shared session.
        let session = NSURLSession.sharedSession()
        
        //step.4 create task
        let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, requestError) -> Void in
            
            //step.6 handle error.
            if requestError != nil{
                //handle error here.
                println("requestError = \(requestError)")
            }else{
                //step.7 parse the response error/success
                //                println(NSString(data: data, encoding: NSUTF8StringEncoding))
                
                self.parseJson(data, completionHandler: {(result, error) -> Void in
                    let results: [NSDictionary] = result?.valueForKey("results") as! [NSDictionary]
                    for oneResult: NSDictionary in results{
                        let mediaUrl:String = oneResult.valueForKey("mediaURL") as! String
                        println("MediaUrl = \(mediaUrl)")
                    }
                })
            }
            
        })
        
        //step.5 make request
        task.resume()
    }
    
    //class function for singleton object
    class func sharedInstance() -> ParseClient{
        struct Singleton{
            static var singletonParseClient = ParseClient()
        }
        return Singleton.singletonParseClient
    }
    
}