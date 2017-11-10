//
//  notification.swift
//  Glanc
//
//  Created by Manmeet Swach on 2016-08-06.
//  Copyright © 2016 Swach. All rights reserved.
//

import Foundation

class notification {
    var id: Int
    var sentUserId: Int
    var recievedUserId: Int
    var username: String
    var displayPic: String
    var type: String
    var lat: Double
    var long: Double
    var timeSent: String
    
    init(id: Int, sentUserId: Int, recievedUserId: Int, username: String, displayPic: String, type: String, lat: Double, long: Double, timeSent: String){
        self.id = id
        self.sentUserId = sentUserId
        self.recievedUserId = recievedUserId
        self.username = username
        self.displayPic = displayPic
        self.type = type
        self.lat = lat
        self.long = long
        self.timeSent = timeSent
    }
}
