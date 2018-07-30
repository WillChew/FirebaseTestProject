//
//  CoffeeRoulettteViewController.swift
//  CoffeeRoulette
//
//  Created by Erik Goossens on 2018-07-27.
//  Copyright © 2018 Erik Goossens. All rights reserved.
//

import UIKit

protocol RandomEventDelegate {
    func sendDataBack(event: Event)
}

class CoffeeRoulettteViewController: UIViewController {
    var firebaseStuff: FirebaseStuff!
    var delegate: RandomEventDelegate?
    var globalEvent: Event?
    
    override func viewDidLoad() {
        super.viewDidLoad()
firebaseStuff = FirebaseStuff()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func goButtonPressed(_ sender: Any) {
        firebaseStuff.randomEvent(){ (event) in
            guard let event = event else { print ("no events"); return }
            self.globalEvent = event
          self.performSegue(withIdentifier: "goToDetailSegue", sender: self)
        }
        
        
        
        
        
//        if delegate != nil {
//            delegate?.sendDataBack(event: randomEvent)
//            dismiss(animated: true, completion: nil)
//        }

    }
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToDetailSegue" {
           let eventConfirmationVC =  segue.destination as? EventConfirmationViewController
//            eventConfirmationVC?.eventTitle = (self.globalEvent?.title)!
//            eventConfirmationVC?.eventTime = (self.globalEvent?.time)!
            eventConfirmationVC?.globalEvent = globalEvent
            
            
        }
    }
    
}
