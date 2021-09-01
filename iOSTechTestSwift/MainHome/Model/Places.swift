//
//  Places.swift
//  iOSTechTestSwift
//
//  Created by athos salmeron on 30/08/21.
//

import Foundation

struct Places: Codable{
    let PlacesList: [Place]

}
struct  Place: Codable {
    let PlaceId: String
    let PlaceName: String
    let Address: String
    let Thumbnail: String
    let IsPetFriendly: Bool
    let Rating: Float
    let Latitude: Double
    let Longitude: Double
    let PhoneNumber: String
    let Site: String
}

