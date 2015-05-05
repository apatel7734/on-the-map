//
//  StudentLocationRequest.swift
//  On the Map
//
//  Created by Ashish Patel on 5/5/15.
//  Copyright (c) 2015 Average Techie. All rights reserved.
//

import Foundation

/*
{
"uniqueKey": "1234",
"firstName": "John",
"lastName": "Doe",
"mapString": "Mountain View, CA",
"mediaURL": "https://udacity.com",
"latitude": 37.386052,
"longitude": -122.083851
}

*/
class StudentLocationRequest: NSObject {
    
    var uniqueKey:String = "9898877889"
    var firstName: String = "Ashish"
    var lastName :String = "Patel"
    var mapString : String?
    var mediaURL: String?
    var latitude: Double?
    var longitude: Double?
    
    init(mapString: String,mediaUrl: String, latitude: Double, longitude: Double){
        self.mapString = mapString
        self.mediaURL = mediaUrl
        self.latitude = latitude
        self.longitude = longitude
    }
    
    func createRequest() -> [String:AnyObject]{
        var requestDict: [String: AnyObject] = [String:AnyObject]()
        requestDict["uniqueKey"] = uniqueKey
        requestDict["firstName"] = firstName
        requestDict["lastName"] = lastName
        requestDict["mapString"] = mapString
        requestDict["mediaURL"] = mediaURL
        requestDict["latitude"] = latitude
        requestDict["longitude"] = longitude
        
        return requestDict
    }
}