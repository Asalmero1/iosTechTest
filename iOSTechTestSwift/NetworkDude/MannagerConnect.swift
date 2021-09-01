//
//  MannagerConnect.swift
//  iOSTechTestSwift
//
//  Created by athos salmeron on 30/08/21.
//

import Foundation
import RxSwift
class ManagerConnections {
    
    func getPlaces() -> Observable<[Place]> {
        return Observable.create{ observer in
            let session = URLSession.shared
            var request = URLRequest(url: URL(string: Constants.URL.main+Constants.EndPoints.urlPlacesList)!)
            request.httpMethod = "GET" 
            // Not necessary usefull but, if we can make it right, we do like that..
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            session.dataTask(with: request){
                (data, response, error) in
                guard let data = data, error == nil ,let response = response as? HTTPURLResponse else {return}
                if response.statusCode == 200 {
                    do
                { let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    
                    let places = try decoder.decode([Place].self, from: data)
                    //print(places)
                    //print(places)

                    
                    observer.onNext(places)
                    //observer.onNext(places.first?.PlacesList)
                    
                }catch let error {
                    print("error reading JSON FILE")
                    
                    print(String(describing: error))
                }
                }
                else  if response.statusCode == 404{
                    print("Error 404")
                }
                observer.onCompleted()
            }.resume()
            return Disposables.create{
                session.finishTasksAndInvalidate()
            }
        }
    }
    func getDetailPlaces(placeID: String, namePlace: String, addressPlace: String, phoneNumber:String, websiteplae:String, ratingPlacel:Float, petFriendly:Bool,latitudePlace:Double,longitudePlace:Double) -> Observable<[PlacesDetail]> {
        return Observable.create{ observer in
            let session = URLSession.shared
            var request = URLRequest(url: URL(string: Constants.URL.main+Constants.EndPoints.urlPlacesList)!)
            request.httpMethod = "GET" // Not necessary usefull but, if we can make it right, we do like that..
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            session.dataTask(with: request){
                (data, response, error) in
                guard let data = data, error == nil ,let response = response as? HTTPURLResponse else {return}
                if response.statusCode == 200 {
                    do
                { let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let detailPlace = try decoder.decode([PlacesDetail].self, from: data)
                    //print(detailPlace)
                    //print(detailPlace[1].PlaceId)
                    
                    
                    observer.onNext(detailPlace)
                    //observer.onNext(places.first?.PlacesList)
                    
                    
                }catch let error {
                    print("error reading JSON FILE")
                    
                    print(String(describing: error))
                }
                }
                else  if response.statusCode == 404{
                    print("Error 404")
                }
                observer.onCompleted()
            }.resume()
            return Disposables.create{
                session.finishTasksAndInvalidate()
            }
        }
    }
    
    func GetDetailPlacesNormal() -> Observable<[PlacesDetail]> {
        return Observable.create{ observer in
            let session = URLSession.shared
            var request = URLRequest(url: URL(string: Constants.URL.main+Constants.EndPoints.urlPlacesList)!)
            request.httpMethod = "GET" // Not necessary usefull but, if we can make it right, we do like that..
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            session.dataTask(with: request){
                (data, response, error) in
                guard let data = data, error == nil ,let response = response as? HTTPURLResponse else {return}
                if response.statusCode == 200 {
                    do
                { let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let detailPlace = try decoder.decode([PlacesDetail].self, from: data)
                    //print(detailPlace)
                    //print(detailPlace[1].PlaceId)
                    
                    
                    observer.onNext(detailPlace)
                    //observer.onNext(places.first?.PlacesList)
                    
                    
                }catch let error {
                    print("error reading JSON FILE")
                    
                    print(String(describing: error))
                }
                }
                else  if response.statusCode == 404{
                    print("Error 404")
                }
                observer.onCompleted()
            }.resume()
            return Disposables.create{
                session.finishTasksAndInvalidate()
            }
        }
    }

}


/*

  guard let stock = detailPlace.first else {return }
  let placeID = stock.PlaceId
  let placeName = stock.PlaceName
  let paceAddress = stock.Address
  let thumNail = stock.Thumbnail
  let petFriend = stock.IsPetFriendly
  let ratingPlace = stock.Rating
  let placeLatitude = stock.Latitude
  let placeLongitude = stock.Longitude
  
  let ConfiguredData = PlacesDetail(PlaceId: placeID, PlaceName: placeName, Address: paceAddress, Thumbnail: thumNail, IsPetFriendly: petFriend, Rating: ratingPlace, Latitude: placeLatitude, Longitude: placeLongitude)
  
 
let arrayConverted =   detailPlace.map{ $0.PlaceId}
  */
