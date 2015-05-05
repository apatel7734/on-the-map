//
//  UdacitySessionResponse.swift
//  On the Map
//
//  Created by Ashish Patel on 5/5/15.
//  Copyright (c) 2015 Average Techie. All rights reserved.
//

import Foundation

/*
----------------
Success response
----------------
{
"current_time": "2015-05-05T19:57:34.461950Z",
"account": {
"registered": false,
"key": "4225928861"
},
"session": {
"id": "1462391854_3bcad10e3e5a3a6e179a00bc949ce88f",
"expiration": "2015-07-04T19:57:34.458210Z"
},
"current_seconds_since_epoch": 1430855854.46195
}

----------------
Error response
----------------
*/

class UdacitySession: NSObject {
    
    let sessionID: String?
    let key: Int?
    let registered: Bool?
    let status: Int?
    let errorMsg: String?
    
    init(jsonDict: NSDictionary){
        errorMsg = jsonDict.valueForKey("error") as? String
        if errorMsg != nil{
            status = jsonDict.valueForKey("status") as? Int
            self.sessionID = nil
            self.key = nil
            self.registered = nil
        }
        else{
            self.status = nil
            let account: NSDictionary = jsonDict.valueForKey("account") as! NSDictionary
            self.key = account.valueForKey("key") as? Int
            self.registered = account.valueForKey("registered") as? Bool
            
            let session: NSDictionary = jsonDict.valueForKey("session") as! NSDictionary
            self.sessionID = session.valueForKey("id") as? String
        }
        
    }
}