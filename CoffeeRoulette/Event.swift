//
//  Event.swift
//  CoffeeRoulette
//
//  Created by Erik Goossens on 2018-07-27.
//  Copyright © 2018 Erik Goossens. All rights reserved.
//

import Foundation

class Event {
    var host: String
    var guest: String
    var title: String
    var time: TimeInterval
    var catchPhrase: String
    var eventID: String?

    
    init(host: String, title:String, time: TimeInterval ) {
        self.host = host
        self.title = title
        self.time = time
        self.guest = ""
        self.catchPhrase = ""
        
    }
    
    func getDictionary() -> [String:Any] {
    
        return ["title": self.title,
            "time": self.time,
            "guest": self.guest,
            "catchPhrase": self.catchPhrase,
            "host":self.host]
    
    }
}
