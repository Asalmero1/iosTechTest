//
//  DetailRouter.swift
//  iOSTechTestSwift
//
//  Created by athos salmeron on 31/08/21.
//


import Foundation
import UIKit

class DetailRouter{
    var viewController: UIViewController{
        return  createViewController()
        
    }
    var placeID:String?
    var namePlace:String?
    var addressPlace:String?
    var addressPlae2: String?
        var phoneNumer: String?
        var websitePlae:String?
        var ratingPlace:Float?
        var petFriendlyPlace:Bool?
        var latitudePlace:Double?
        var longiteplace:Double?
    
    init(placeID: String? = "" , namePlace: String? = "", addressPlace: String? = "", addressPlace2: String? = "", phoneNumber:String? = "", websiteplae:String? = "", ratingPlacel:Float? = 0.0 , petFriendly:Bool? = false,latitudePlace:Double? = 0.0,longitudePlace:Double? = 0.0) {
        self.placeID         = placeID
        self.namePlace       = namePlace
        self.addressPlace    = addressPlace
        self.addressPlae2    = addressPlace2
        self.phoneNumer      = phoneNumber
        self.websitePlae     = websiteplae
        self.ratingPlace      = ratingPlacel
        self.petFriendlyPlace = petFriendly
        self.latitudePlace    = latitudePlace
        self.longiteplace     = longitudePlace
        
    }
   
    
    private var sourceView: UIViewController?

    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("Erro desconocido (para ti, porque quiza yo si sepa :P y lo solucionaré)")}
        self.sourceView = view
        
        
    }
    private func createViewController() -> UIViewController {
        let view = DetailView(nibName: "DetailView", bundle: Bundle.main)
        view.placeID = self.placeID
        view.namePlace = self.namePlace
        view.addressPlace = self.addressPlace
        view.phoneNumer = self.phoneNumer
        view.websitePlae = self.websitePlae
        view.ratingPlace = self.ratingPlace
        view.petFriendlyPlace = self.petFriendlyPlace
        view.latitudePlace = self.latitudePlace
        view.longiteplace = self.longiteplace
        
        return view
    }
}
