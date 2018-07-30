//
//  APIRequestManager.swift
//  CoffeeRoulette
//
//  Created by Will Chew on 2018-07-28.
//  Copyright © 2018 Erik Goossens. All rights reserved.
//

import Foundation

enum Constants {
    static let key = "key"
    static let api = "AIzaSyDBkRECsxw7TPdZn3QiJbxX2ImmwedX1lc"
    static let location = "location"
    static let radius = "radius"
    static let keyword = "keyword"
    static let coffee = "coffee"
}

class APIRequestManager {
    
    
    func getLocations(){
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let url = URL(string: "https://maps.googleapis.com")!
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)!
        components.path = "/maps/api/place/nearbysearch/json"
        let keyQueryItem = URLQueryItem(name: Constants.key, value: Constants.api)
        let locationQueryItem = URLQueryItem(name: Constants.location, value: "43.6446,-79.3950")
        let radiusQueryItem = URLQueryItem(name: Constants.radius, value: "500")
        let keywordQueryItem = URLQueryItem(name: Constants.keyword, value: Constants.coffee)
        components.queryItems = [keyQueryItem, locationQueryItem, radiusQueryItem, keywordQueryItem]
        var request = URLRequest(url: components.url!)
        request.httpMethod = "GET"
        
         let task = session.dataTask(with: request, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            if (error == nil) {
                //success
                let statusCode = (response as! HTTPURLResponse).statusCode
                print(#line, "Success: \(statusCode)")
            } else if let error = error {
                print(#line, error.localizedDescription)
            }
            
            guard let data = data else { return }
            guard let jsonResult = try! JSONSerialization.jsonObject(with: data) as? Dictionary<String,Any?> else { return }
            let cafes = jsonResult["results"]
            print(cafes)
            
            
            
        })
        
        
        task.resume()
        session.finishTasksAndInvalidate()
    }
    
}
