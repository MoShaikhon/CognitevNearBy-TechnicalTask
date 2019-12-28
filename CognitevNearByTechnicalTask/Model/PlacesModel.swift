//
//  PlacesModel.swift
//  CognitevNearByTechnicalTask
//
//  Created by Mohamed Shaikhon on 12/26/19.
//  Copyright © 2019 Mohamed Shaikhon. All rights reserved.
//

import Foundation
import UIKit

struct Response: Codable {
    let response: Place
}
struct Place: Codable {
    let venues: [Venue]
   
}
struct Venue: Codable {
    let id, name: String
    let location: Location
    let categories: [Category]
    let hasPerk: Bool
    
    enum CodingKeys: String, CodingKey {
        case id, name, location, categories
        case hasPerk
    }
}
struct Location: Codable {
    let address: String?
    let lat, lng: Double
    let distance: Int
    let cc: String
    let city, state: String?
    let country: String
    let formattedAddress: [String]
}


struct Category: Codable {
    let id, name, pluralName, shortName: String
    let icon: Icon
    let primary: Bool
}
struct Icon: Codable {
    let iconPrefix: String
    let suffix: String
    
    enum CodingKeys: String, CodingKey {
        case iconPrefix = "prefix"
        case suffix
    }
}
