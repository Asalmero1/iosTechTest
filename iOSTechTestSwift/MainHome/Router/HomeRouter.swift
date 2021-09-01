//
//  HomeRouter.swift
//  iOSTechTestSwift
//
//  Created by athos salmeron on 30/08/21.
//

import Foundation
import UIKit

class HomeRouter{
    var viewController: UIViewController{
        return  createViewController()
        
    }
    
    private var sourceView: UIViewController?

    private func createViewController() -> UIViewController {
        let view = HomeMainView(nibName: "HomeMainView", bundle: Bundle.main)
        return view
    }
    
    
    func setSourceView(_ sourceView:UIViewController?){
        guard let view = sourceView else {fatalError("Erro desconocido (para ti, porque quiza yo si sepa :P y lo solucionaré)")}
        self.sourceView = view
        
        
    }
    
    func navigateToDetailView(placeID: String, namePlace: String, addressPlace: String, addressPlace2 : String, phoneNumber:String, websiteplae:String, ratingPlacel:Float, petFriendly:Bool,latitudePlace:Double,longitudePlace:Double){
        //let detailView = DetailRouter(placeID: placeID).viewController
        let detailView = DetailRouter(placeID: placeID, namePlace: namePlace, addressPlace: addressPlace, addressPlace2:addressPlace2 , phoneNumber: phoneNumber, websiteplae: websiteplae, ratingPlacel: ratingPlacel, petFriendly: petFriendly, latitudePlace: latitudePlace, longitudePlace: longitudePlace).viewController
       
        sourceView?.navigationController?.pushViewController(detailView, animated: true)
    }
 
}
