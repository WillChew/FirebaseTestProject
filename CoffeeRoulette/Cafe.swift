//
//  Cafe.swift
//  CoffeeRoulette
//
//  Created by Will Chew on 2018-07-30.
//  Copyright © 2018 Erik Goossens. All rights reserved.
//
import Foundation
import CoreLocation
import MapKit

class Cafe {
    var cafeName: String
    var location: CLLocationCoordinate2D
    var photo: UIImage?
    
    init(cafeName: String, location: CLLocationCoordinate2D) {
        self.cafeName = cafeName
        self.location = location
    }
}
