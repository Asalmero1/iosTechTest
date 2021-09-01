//
//  ExtensionsUrl.swift
//  iOSTechTestSwift
//
//  Created by athos salmeron on 30/08/21.
//

import UIKit

extension UIImageView{
    func retreiveImageFromServerURL(urlString: String, placeholderImage: UIImage){
        if self.image == nil {
            self.image = placeholderImage
        }
        URLSession.shared.dataTask(with: URL(string: urlString)!){data, response, error in
            if error != nil{
                return
            }
            DispatchQueue.main.async {
                guard let data = data else {return}
                let image = UIImage(data: data)
                self.image = image
            }
        }.resume()
    }
}



//optional code for imgview
/*
let placeID = places[indexPath.row].PlaceId

let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.photos.rawValue))

placesClient.fetchPlace(fromPlaceID: placeID, placeFields: fields, sessionToken: nil, callback: {
    (place: GMSPlace?, error: Error?) in
    if let error = error {
        print("an error was ocurred \(error.localizedDescription)")
        return
    }
    if let place = place {
        let photoMetadato:GMSPlacePhotoMetadata = place.photos![0]
        self.placesClient.loadPlacePhoto(photoMetadato, callback: {(photo,error) -> Void in
            if let errorr = error {
                print("Error loading photo")
                return
            }else{
                //cell.imagePlace.image = photo
                
            }
            
        })
        
    }
    
})
*/ //Use in case you want to load by ID
/*
let urlString = places[indexPath.row].Thumbnail

   if let url = URL(string: urlString)
   {
       let urlRequest = URLRequest(url: url)
       NSURLConnection.sendAsynchronousRequest(urlRequest, queue: OperationQueue.main, completionHandler: {(response, data, error) in
           if let data = data
           {
               let image = UIImage(data: data)
               cell.imagePlace.image = image
           }
           else
           {
               cell.imagePlace.image = UIImage(named: "placeholder")
           }
       })
   }
 */
//print("hasta aca vamos bien")
