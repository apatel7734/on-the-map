//
//  Constants.swift
//  On the Map
//
//  Created by Ashish Patel on 4/26/15.
//  Copyright (c) 2015 Average Techie. All rights reserved.
//

import Foundation

extension ParseClient{
    struct Constants {
        static let APPLICATION_ID: String = "QrX47CA9cyuGewLdsL7o5Eb8iug6Em8ye0dnAbIr"
        static let REST_API_KEY: String = "QuWThTdiRmTux3YaDseUSEpUKo7aBYM737yKd4gY"
        static let BASE_URL: String = "https://api.parse.com/1/classes/"
        
    }
    
    struct Methods {
        static let STUDENT_LOCATION: String = "StudentLocation"
        static let POST = "POST"
        static let GET = "GET"
    }
    
    struct Parameters {
        static let LIMIT = "limit"
        static let APP_ID_KEY = "X-Parse-Application-Id"
        static let REST_API_KEY = "X-Parse-REST-API-Key"
        static let APPLICATION_JSON = "application/json"
        static let CONTENT_TYPE = "Content-Type"
        static let RESULTS = "results"
    }
    
}

extension UdacityClient{
    
    struct Constants {
        static let BASE_URL: String = "https://www.udacity.com/api/"
        
    }
    
    struct Methods {
        static let POST = "POST"
        static let GET = "GET"
        static let SESSION:String="session"
    }
    
    struct Parameters {
        static let APPLICATION_JSON = "application/json"
        static let CONTENT_TYPE = "Content-Type"
        static let ACCEPT = "Accept"
    }
}

