//
//  DetailView.swift
//  iOSTechTestSwift
//
//  Created by athos salmeron on 31/08/21.
//

import UIKit
import RxSwift
import GoogleMaps
class DetailView: UIViewController {
    @IBOutlet var titlePlaceTxt: UILabel!
    @IBOutlet var distancePlaceTxt: UILabel!
    @IBOutlet var petFriendlyImg: UIImageView!
    @IBOutlet var addressPlaceTxt: UILabel!
    @IBOutlet var ratingView: StarRatingView!
    @IBOutlet var mapView: UIView!
    private var router = DetailRouter()
    private var viewModel = detailViewModel()
    private var disposeBag = DisposeBag()
    private var PassedPlace = [PlacesDetail]()
    private var lugar = [Lugar]()
    @IBOutlet var tableView: UITableView!
    var placeID:String?
    var namePlace:String?
    var addressPlace:String?
    var phoneNumer: String?
    var websitePlae:String?
    var ratingPlace:Float?
    var petFriendlyPlace:Bool?
    var latitudePlace:Double?
    var longiteplace:Double?
    public static var webpass: String = "http://google.com"
    
    //LocalVariables
    var coordenada1: Double = 0.0
    var coordenada2: Double = 0.0
    var ratingStar: Float = 0.0
    var options: [String] = ["Directions","Call","Visit Website"]
    var locManager = CLLocationManager()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        viewModel.bind(view: self, router: router)
        
        self.navigationItem.title = "DETAIL"
        self.navigationController?.navigationBar.tintColor = .black
        
        
        
        //print("llegamos aqui")
        configTableView()
        getDataDetailandShow()
        
        // Do any additional setup after loading the view.
    }
    private func configTableView(){
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName:"DetailCell", bundle: nil), forCellReuseIdentifier: "cell")
        
    }
    
    private func getDataDetailandShow(){
        return viewModel.getListPlacesData()
            .subscribe(on: MainScheduler.instance)
            .observe(on: MainScheduler.instance)
            .subscribe{ places in
                self.PassedPlace = places
                self.showPlaceData()
                
            }onError: { error in
                print(error.localizedDescription)
            }onCompleted: {
                
            }.disposed(by: disposeBag)
        
        
    }
    func showPlaceData(){
        DispatchQueue.main.async { [self] in
            
            self.coordenada1 = self.latitudePlace!
            self.coordenada2 = self.longiteplace!
            self.titlePlaceTxt.text = self.namePlace
            self.addressPlaceTxt.text = self.addressPlace
            self.ratingView?.rating = self.ratingPlace!
            DetailView.webpass = self.websitePlae!
            print(self.coordenada1)
            
            if self.petFriendlyPlace == false{
                self.petFriendlyImg.image = UIImage(named: "nodog")
            }
            else if self.petFriendlyPlace == true {
                self.petFriendlyImg.image = UIImage(named: "bluedog")
            }
            
            
            var currentLocation: CLLocation!
            if
                CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
                    CLLocationManager.authorizationStatus() ==  .authorizedAlways
            {
                currentLocation = self.locManager.location
            }
            
            //print(currentLocation.coordinate.latitude)
            // print(currentLocation.coordinate.longitude)
            if  let latitude = self.locManager.location?.coordinate.latitude,
                let longitude = self.locManager.location?.coordinate.longitude{
            let fetchedLatitude  = self.coordenada1
            let fetchedLongitude = self.coordenada2
            
            let userlocation = CLLocation(latitude: latitude, longitude: longitude)
            let YummiLocation = CLLocation(latitude: fetchedLatitude, longitude: fetchedLongitude)
            let distance  = userlocation.distance(from: YummiLocation) / 1069
            self.distancePlaceTxt.text = "\(String(format:"%.02f", distance)) mi"
            
            
            }
            
            
            //MapViewConfig
            let camera = GMSCameraPosition.camera(withLatitude: self.coordenada1, longitude: self.coordenada2, zoom: 14.0)
            let mapView = GMSMapView.map(withFrame: self.mapView.frame, camera: camera)
            self.view.addSubview(mapView)
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: self.coordenada1, longitude: self.coordenada2)
            marker.title = self.namePlace
            marker.snippet = self.addressPlace
            marker.icon = GMSMarker.markerImage(with: UIColor(red: 44, green: 96, blue: 133, alpha: 1))
            marker.icon = UIImage(named: "CustomMarker")
            marker.map = mapView
            //Finish MapView Conf
            
        }
    }
    
    
    
}
/* this is an optional Extension for Viewdelegte
 extension DetailView: GMSMapViewDelegate {
 
 // tap map marker
 func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
 //print("didTap marker \(marker.title)")
 
 // remove color from currently selected marker
 if let selectedMarker = mapView.selectedMarker {
 selectedMarker.icon = GMSMarker.markerImage(with: nil)
 }
 
 // select new marker and make green
 mapView.selectedMarker = marker
 marker.icon = GMSMarker.markerImage(with: UIColor(red: 44, green: 96, blue: 133, alpha: 0))
 
 // tap event handled by delegate
 return true
 }
 }
 */
extension DetailView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return options.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! DetailCell
        cell.textOption.text = options[indexPath.row]
        if options[indexPath.row] == "Directions" {
            cell.imgOption.image = UIImage(named: "route")
            cell.CustomInformation.text = self.addressPlace
        }
        else if options[indexPath.row] == "Call" {
            cell.imgOption.image = UIImage(named: "phone")
            cell.CustomInformation.text = self.phoneNumer
        }
        else if options[indexPath.row] == "Visit Website" {
            cell.imgOption.image = UIImage(named: "link")
            cell.CustomInformation.text = self.websitePlae
        }
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if options[indexPath.row] == "Visit Website" {
            /* just testable code for url
            if let url = URL(string: self.websitePlae!)
            {
                UIApplication.shared.open(url)
            }
            */
            
            
            let newViewController = WebViewController(nibName: "WebViewController", bundle: nil)

            self.navigationController?.show(newViewController, sender:nil)
            
        }
        else  if options[indexPath.row] == "Call" {
            let numeroDeTelefono:String = self.phoneNumer!.components(separatedBy:CharacterSet.decimalDigits.inverted).joined()
            
            print(numeroDeTelefono)
            guard let phoneNumber = URL(string: "tel://\(numeroDeTelefono)") else {return}
            UIApplication.shared.open(phoneNumber)
        }
        if options[indexPath.row] == "Directions" {
            var currentLocation:CLLocation!
            if
                CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
                    CLLocationManager.authorizationStatus() ==  .authorizedAlways
            {
                currentLocation = self.locManager.location
            }
            let coordinateMap1Lat:String = String(self.latitudePlace!)
            let coordinateMap2Long:String = String(self.longiteplace!)
           
           
            let userlatitude:Double =  currentLocation.coordinate.latitude
            let userlongitude:Double  = currentLocation.coordinate.longitude
            
            UIApplication.shared.open(URL(string:"http://maps.apple.com/maps?saddr=\(userlatitude),\(userlongitude)&daddr=\(coordinateMap1Lat),\(coordinateMap2Long)")!)
            print(coordinateMap2Long)
            
            
            
        }
    }
}
