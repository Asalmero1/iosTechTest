//
//  HomeMainView.swift
//  iOSTechTestSwift
//
//  Created by athos salmeron on 30/08/21.
//

import UIKit
import RxSwift
import RxCocoa
import GooglePlaces
import CoreLocation
import Kingfisher
class HomeMainView: UIViewController, CLLocationManagerDelegate {
  
    @IBOutlet weak var tableView: UITableView!
    private var router = HomeRouter()
    private var viewModel = HomeViewModel()
    private var disposeBag = DisposeBag()
    private var places = [Place]()
    private var placesClient: GMSPlacesClient!
    private var petAllowed = true
    var locManager = CLLocationManager()
    private var cellHeightsDictionary: [String: CGFloat] = [:]
    


    override func viewDidLoad() {
        locManager = CLLocationManager()
        locManager.delegate = self
        locManager.requestAlwaysAuthorization()

           view.backgroundColor = .gray
    
        //Configure StatusBar
        let statusImage = UIImage(named: "figoLogo")
        let imageView = UIImageView(image: statusImage)
        //imageView.frame = CGRect(x: 0, y: 0, width: 10, height: 50)
        self.navigationItem.titleView = imageView
        //navigationController?.navigationBar.prefersLargeTitles = true
        let customBar = UINavigationBarAppearance()
        customBar.backgroundColor = UIColor(red: 255, green: 255, blue: 255, alpha: 0)
        navigationController?.navigationBar.tintColor = .white
       
        //finish status bar config
        //self.navigationItem.title = "TechTest"
        
        super.viewDidLoad()
     
        viewModel.bind(view: self, router: router)
        configTableView()
        getData()
        
         //placesClient = GMSPlacesClient.shared()
       
        // Do any additional setup after loadin g the view.
        
       
    }
   
   
    private func configTableView(){
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(UINib(nibName:"CustomPlaceCell", bundle: nil), forCellReuseIdentifier: "cell")
       
    }
    private func getData(){
        return viewModel.getListPlacesData()
        //Concurrency Process RxSwift lml
            .subscribe(on: MainScheduler.instance)
            .observe(on: MainScheduler.instance)
            .subscribe{places in
                self.places = places
                self.reloadTable()
                //self.tableView.reloadData()
                
            }onError: { error in
                print(error.localizedDescription)
            }onCompleted: {
                
            }.disposed(by: disposeBag)
        
    }
    private func reloadTable(){
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    
    
}
extension HomeMainView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(places.count)
      
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CustomPlaceCell
        if cell == nil {
            cell = CustomPlaceCell(style: .default, reuseIdentifier: "cell")
        }
        
      
        
            
        cell.titlePlace.text = places[indexPath.row].PlaceName
        cell.addressPlace.text = places[indexPath.row].Address
        if places[indexPath.row].IsPetFriendly == false {
            cell.petFriendlyTxt.text = ""
            cell.imagePetFriendly.image = UIImage(named: "nodog")
        }
        else if places[indexPath.row].IsPetFriendly == true{
            cell.petFriendlyTxt.text = "Pet Friendly"
            cell.imagePetFriendly.image = UIImage(named: "bluedog")
        }
        
        let ratingStar = places[indexPath.row].Rating
       
        
           CustomPlaceCell.SendRating = ratingStar
        
         // IMAGE DATA
        
            //let url = URL(string: self.places[indexPath.row].Thumbnail)!

     /*
            if let data = try? Data(contentsOf: url) {
                // Create Image and Update Image View
                let imagenes = UIImage(data: data)
                    
               
            }
        
         
            */
        let url = URL(string: self.places[indexPath.row].Thumbnail)
        cell.imagePlace.kf.setImage(with: url,placeholder: UIImage(named: "placeholder"))
        var currentLocation: CLLocation!
        if
           CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
           CLLocationManager.authorizationStatus() ==  .authorizedAlways
        {
            currentLocation = self.locManager.location
        }
      
        //print(currentLocation.coordinate.latitude)
       // print(currentLocation.coordinate.longitude)
        let latitude = currentLocation.coordinate.latitude // If there is an error in this point its because you didnt accept the location permissions (only when uses simulator)
        let longitude = currentLocation.coordinate.longitude
            let fetchedLatitude  = self.places[indexPath.row].Latitude
            let fetchedLongitude = self.places[indexPath.row].Longitude
        
        let userlocation = CLLocation(latitude: latitude, longitude: longitude)
        let YummiLocation = CLLocation(latitude: fetchedLatitude, longitude: fetchedLongitude)
        let distance  = userlocation.distance(from: YummiLocation) / 1069
        cell.distancePlace.text = "\(String(format:"%.02f", distance)) mi"
        
            
       
        
        return cell
        
       
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 126
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        viewModel.makeDetailView(placeID: self.places[indexPath.row].PlaceId, namePlace: self.places[indexPath.row].PlaceName, addressPlace: self.places[indexPath.row].Address,addressPlace2: self.places[indexPath.row].Address, phoneNumber: self.places[indexPath.row].PhoneNumber, websiteplae: self.places[indexPath.row].Site, ratingPlacel: self.places[indexPath.row].Rating, petFriendly: self.places[indexPath.row].IsPetFriendly, latitudePlace: places[indexPath.row].Latitude, longitudePlace: places[indexPath.row].Longitude)
    }
    
    
}

