//
//  EventConfirmationViewController.swift
//  CoffeeRoulette
//
//  Created by Erik Goossens on 2018-07-27.
//  Copyright © 2018 Erik Goossens. All rights reserved.
//

import UIKit

class EventConfirmationViewController: UIViewController{
    var firebaseStuff: FirebaseStuff!
    var globalEvent: Event!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var titleLabel: UILabel!
    
 
    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        firebaseStuff = FirebaseStuff()
        
        let date = Date(timeIntervalSince1970: globalEvent.time)
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .none
        let localDate = formatter.string(from: date)
        timeLabel.text = String(localDate)
        titleLabel.text = globalEvent.title

        
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToLastScreenSegue" {
            let vc: EventDetailViewController = segue.destination as! EventDetailViewController
            vc.event = globalEvent
            
            vc.event.guest = (UserDefaults.standard.object(forKey: "user") as? String)!
            vc.event.catchPhrase = "testing"
            
            
        }
    }

    
    @IBAction func tryAgainButtonPressed(_ sender: UIButton) {
        firebaseStuff.randomEvent{ (event) in
            guard let event = event else { return }
            DispatchQueue.main.async {
                self.globalEvent = event
                
                let date = Date(timeIntervalSince1970: self.globalEvent.time)
                let formatter = DateFormatter()
                formatter.timeStyle = .medium
                formatter.dateStyle = .none
                let localDate = formatter.string(from: date)
              
                
                self.titleLabel.text = self.globalEvent.title
                self.timeLabel.text = localDate
            }
    }
        
    }
    @IBAction func confirmButtonPressed(_ sender: UIButton) {
//        globalEvent = Event(host: UserDefaults.standard.object(forKey: "user") as! String, title: titleLabel.text!, time: timeLabel.text!)
        firebaseStuff.guestConfirming(globalEvent)
    }
    
}
