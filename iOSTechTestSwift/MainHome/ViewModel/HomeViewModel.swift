//
//  HomeViewModel.swift
//  iOSTechTestSwift
//
//  Created by athos salmeron on 30/08/21.
//

import Foundation
import RxSwift

class HomeViewModel{
    private weak var view: HomeMainView?
    private var router: HomeRouter?
    private var manager4Connections = ManagerConnections()
    
    func bind(view: HomeMainView, router: HomeRouter){
        self.view = view
        self.router = router
        self.router?.setSourceView(view)
    }
    
    func getListPlacesData() -> Observable<[Place]>{
       
        return manager4Connections.getPlaces()
    }
    
    func makeDetailView(placeID: String, namePlace: String, addressPlace: String, addressPlace2: String, phoneNumber:String, websiteplae:String, ratingPlacel:Float, petFriendly:Bool,latitudePlace:Double,longitudePlace:Double){
        router?.navigateToDetailView(placeID: placeID, namePlace: namePlace, addressPlace: addressPlace, addressPlace2: addressPlace2, phoneNumber: phoneNumber, websiteplae: websiteplae, ratingPlacel: ratingPlacel, petFriendly: petFriendly, latitudePlace: latitudePlace, longitudePlace: longitudePlace)
    }
    
    
}
