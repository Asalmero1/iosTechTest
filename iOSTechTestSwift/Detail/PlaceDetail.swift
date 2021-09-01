//
//  MovieDetail.swift
//  iOSTechTestSwift
//
//  Created by athos salmeron on 31/08/21.
//

import Foundation

struct Lugar: Codable{
    let PlacesDetalle: [PlacesDetail]

}

struct  PlacesDetail: Codable {
   public let PlaceId: String?
 public let PlaceName: String?
 public let Address: String?
 public let Thumbnail: String?
 public let IsPetFriendly: Bool?
 public let Rating: Float?
 public let Latitude: Double?
 public let Longitude: Double?
    
    
    
}
private enum CodingKeys: String, CodingKey {
        case PlaceID
        case PlaceName
        case Address
        case Thumbnail
        case IsPetFriendly
        case Rating
        case Latitude
        case Longitude
        
     
    }
