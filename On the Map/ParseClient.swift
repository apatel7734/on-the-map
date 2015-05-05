//
//  ParseClient.swift
//  On the Map
//
//  Created by Ashish Patel on 4/29/15.
//  Copyright (c) 2015 Average Techie. All rights reserved.
//

import Foundation

class ParseClient: NetworkClient {
    
    func getStudentLocations(completionHandler: (studentLocations: [StudentLocation]?,error: NSError?) -> Void){
        
        let parameters = [Parameters.LIMIT : 100]
        
        var urlString = Constants.BASE_URL + Methods.STUDENT_LOCATION  + escapedParameters(parameters)
        let url = NSURL(string: urlString)
        
        //step.1 create request
        let request = NSMutableURLRequest(URL: url!)
        
        //step.2 add request values
        request.HTTPMethod = Methods.GET
        request.addValue(Constants.APPLICATION_ID, forHTTPHeaderField: Parameters.APP_ID_KEY)
        request.addValue(Constants.REST_API_KEY, forHTTPHeaderField: Parameters.REST_API_KEY)
        
        
        //setp.3 get shared session.
        let session = NSURLSession.sharedSession()
        
        //step.4 create task
        let task = session.dataTaskWithRequest(request, completionHandler: { (data, response, requestError) -> Void in
            
            //step.6 handle error.
            if requestError != nil{
                //handle error here.
                completionHandler(studentLocations: nil, error: requestError)
                
            }else{
                //step.7 parse the response error/success
                //                println(NSString(data: data, encoding: NSUTF8StringEncoding))
                
                self.parseJson(data, completionHandler: {(result, error) -> Void in
                    let results: [NSDictionary] = result?.valueForKey(Parameters.RESULTS) as! [NSDictionary]
                    
                    var studentLocations:[StudentLocation] = [StudentLocation]()
                    
                    for oneResult: NSDictionary in results{
                        var studentLocation = StudentLocation(jsonDisctionary: oneResult)
                        studentLocations.append(studentLocation)
                    }
                    completionHandler(studentLocations: studentLocations, error: nil)
                    
                })
            }
            
        })
        
        //step.5 make request
        task.resume()
    }
    
    /**
    * post student location.
    */
    func postStudentLocation(){
        
        var urlString = NSURL(string: Constants.BASE_URL + Methods.STUDENT_LOCATION)
        
        //step.1 - Url Request
        let request = NSMutableURLRequest(URL: urlString!)
        //step.2 - Add request values
        request.HTTPMethod = Methods.POST
        request.addValue(Constants.APPLICATION_ID, forHTTPHeaderField: Parameters.APP_ID_KEY)
        request.addValue(Constants.REST_API_KEY, forHTTPHeaderField: Parameters.REST_API_KEY)
        request.addValue(Parameters.APPLICATION_JSON, forHTTPHeaderField: Parameters.CONTENT_TYPE)
        request.HTTPBody = "{\"uniqueKey\": \"1234\", \"firstName\": \"John\", \"lastName\": \"Doe\",\"mapString\": \"Mountain View, CA\", \"mediaURL\": \"https://udacity.com\",\"latitude\": 37.386052, \"longitude\": -122.083851}".dataUsingEncoding(NSUTF8StringEncoding)
        
        //step.3 - session
        let session = NSURLSession.sharedSession()
        //step.4 - create task for request
        let task = session.dataTaskWithRequest(request) { data, response, error in
            //step.6 - check for errors
            if error != nil { // Handle error…
                return
            }
            //step.7 - parse response.
            println(NSString(data: data, encoding: NSUTF8StringEncoding))
        }
        //step.5 - call network request.
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