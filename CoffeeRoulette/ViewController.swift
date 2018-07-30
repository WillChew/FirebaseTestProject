//
//  ViewController.swift
//  CoffeeRoulette
//
//  Created by Erik Goossens on 2018-07-26.
//  Copyright © 2018 Erik Goossens. All rights reserved.
//

import UIKit
import FirebaseDatabase
import MapKit


class ViewController: UIViewController {
    
    var ref: DatabaseReference!
    var eventsRef: DatabaseReference!
    var event: Event!
    var time: TimeInterval!
    @IBOutlet weak var mapView: MKMapView!
    var tapGesture: UITapGestureRecognizer!
    var datePickerView: UIDatePicker!
    
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var timeTextField: UITextField!
    
    
    
    override func viewDidLoad() {
        ref = Database.database().reference()
        eventsRef = ref.child("events")
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.view.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        mapView.isHidden = false
        datePickerView.removeFromSuperview()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    // Test comment
    
    @IBAction func submitButtonPressed(_ sender: UIButton) {
        guard let title = titleTextField.text, title.count > 0 else {
            return
        }
        let host = UserDefaults.standard.object(forKey: "user") as? String
        event = Event(host: host!, title: title, time: time)
        print(event.title)
        
        let generatedRef = ref.child("events").childByAutoId()
        //        generatedRef.setValue(["title": event.title, "time": event.time, "host": event.host])
        generatedRef.setValue(event.getDictionary())
        
        performSegue(withIdentifier: "goToLastScreenSegue", sender: self)
        
        
    }
    
    @IBAction func unwindToVC1(segue:UIStoryboardSegue ) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToLastScreenSegue" {
            let vc = segue.destination as? EventDetailViewController
            vc?.event = event
        }
    }
    
    @IBAction func timeTextField2(_ sender: UITextField) {
        
        let calendar = Calendar.current
        let todayNow = Date()
        let todayEnd = calendar.date(bySettingHour: 23, minute: 59, second: 59, of: todayNow)
        
        datePickerView = UIDatePicker()
        datePickerView.maximumDate = todayEnd
        datePickerView.minimumDate = todayNow
        datePickerView.datePickerMode = .time
        datePickerView.minuteInterval = 5
        sender.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(ViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
        mapView.isHidden = true
    }
    
    
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        timeTextField.text = formatter.string(from: sender.date)
        time = sender.date.timeIntervalSince1970
        print(#line, time)
    }
    
}

//make tapgesture to dismiss textfield





