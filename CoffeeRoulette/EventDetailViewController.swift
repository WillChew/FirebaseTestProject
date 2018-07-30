//
//  EventDetailViewController.swift
//  CoffeeRoulette
//
//  Created by Erik Goossens on 2018-07-27.
//  Copyright © 2018 Erik Goossens. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var guestStatusLabel: UILabel!
    @IBOutlet weak var catchphraseLabel: UILabel!
    
    var eventTitle: String = ""
    var eventTime: String = ""
    var guestStatus: String = ""
    var event: Event!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         let date = Date(timeIntervalSince1970: event.time)
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .medium
        let localDate = formatter.string(from: date)
        timeLabel.text = localDate
        
        titleLabel.text = event.title
        if (event.guest == "") {
            guestStatusLabel.text = "No match found"
        } else {
            guestStatusLabel.text = "Match found"
        }
        catchphraseLabel.text = event.catchPhrase

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
    
    @IBAction func goBack(_sender: Any) {
        performSegue(withIdentifier: "unwindSegue", sender: self)
    }

}
