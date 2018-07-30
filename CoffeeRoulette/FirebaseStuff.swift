//
//  FirebaseStuff.swift
//  CoffeeRoulette
//
//  Created by Erik Goossens on 2018-07-27.
//  Copyright © 2018 Erik Goossens. All rights reserved.
//

import Foundation
import FirebaseDatabase

class FirebaseStuff {
    var ref: DatabaseReference!
    var eventsRef: DatabaseReference!
    var event: Event!

    
    func randomEvent(completion: @escaping(Event?)-> Void)  {
    Database.database().reference().child("events").queryOrdered(byChild: "title").observe(.value) { (snapshot) in
            guard let results = snapshot.value as? [String:[String: Any]] else { return }
            print(results.count)
            var resultsArray = Array(results)
            print(resultsArray[0].value)
            let random = Int(arc4random_uniform(UInt32(results.count)))
            let randomEventInfo = resultsArray[random]
            
            guard let title = randomEventInfo.value["title"] as? String,
                let time = randomEventInfo.value["time"] as? TimeInterval,
                let host = randomEventInfo.value["host"] as? String else { return }
            
            self.event = Event(host: host, title: title, time: time)
            self.event.eventID = randomEventInfo.key
            print(self.event.host)
        
        
            completion(self.event)
        
            
        }
    }
    func guestConfirming(_ eventPassed: Event) {
        
        Database.database().reference().child("events").child(eventPassed.eventID!).child("guest").setValue(UserDefaults.standard.object(forKey: "user") as! String)

}

}
