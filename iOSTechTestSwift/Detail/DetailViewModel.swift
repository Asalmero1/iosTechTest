//
//  DetailViewModel.swift
//  iOSTechTestSwift
//
//  Created by athos salmeron on 31/08/21.
//

import Foundation
import RxSwift
class detailViewModel {
    private var managerConnections = ManagerConnections()
    private(set) weak var  view:DetailView?
    private var router: DetailRouter?
    
    func bind(view: DetailView, router: DetailRouter){
        self.view = view
        self.router = router
        //TO DO: set la view en el router
        self.router?.setSourceView(view)
        
    }
    func getListPlacesData() -> Observable<[PlacesDetail]>{
       
        return managerConnections.GetDetailPlacesNormal()
    }
    func getPlacesData(placeID: String, namePlace: String, addressPlace: String, phoneNumber:String, websiteplae:String, ratingPlacel:Float, petFriendly:Bool,latitudePlace:Double,longitudePlace:Double) -> Observable<[PlacesDetail]> {
        return managerConnections.getDetailPlaces(placeID: placeID, namePlace: namePlace, addressPlace: addressPlace, phoneNumber: phoneNumber, websiteplae: websiteplae, ratingPlacel: ratingPlacel, petFriendly: petFriendly, latitudePlace: latitudePlace, longitudePlace: longitudePlace)
    }
}
