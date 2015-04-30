//
//  StudentLocation.swift
//  On the Map
//
//  Created by Ashish Patel on 4/29/15.
//  Copyright (c) 2015 Average Techie. All rights reserved.
//

import Foundation
import CoreLocation

/*
"mediaURL" : "http://www.linkedin.com/pub/gabrielle-miller-messner/11/557/60/en",
"firstName" : "Gabrielle",
"longitude" : -79.3922539,
"uniqueKey" : "2256298598",
"latitude" : 35.1740471,
"objectId" : "8ZEuHF5uX8",
"createdAt" : "2015-02-24T22:35:30.639Z",
"updatedAt" : "2015-03-11T03:23:49.582Z",
"mapString" : "Southern Pines, NC",
"lastName" : "Miller-Messner"
*/
class StudentLocation {
    
    let mediaUrl: String?
    let firstName: String?
    let lastName: String?
    let longitude: CLLocationDegrees?
    let latitude: CLLocationDegrees?
    let objectId: String?
    let mapString: String?
    
    init(jsonDisctionary: NSDictionary){
        
        self.mediaUrl = jsonDisctionary.valueForKey("mediaURL") as? String
        self.firstName = jsonDisctionary.valueForKey("firstName") as? String
        self.lastName = jsonDisctionary.valueForKey("lastName") as? String
        self.latitude = jsonDisctionary.valueForKey("latitude") as? CLLocationDegrees
        self.longitude = jsonDisctionary.valueForKey("longitude")as? CLLocationDegrees
        self.mapString = jsonDisctionary.valueForKey("mapString") as? String
        self.objectId = jsonDisctionary.valueForKey("objectId") as? String
        
    }
    
}