//
//  LocationService.swift
//  iOSTechTestSwift
//
//  Created by athos salmeron on 31/08/21.
//

import Foundation
import CoreLocation
import UIKit

public protocol LocalizationHelperDelegate: AnyObject {
    func didUpdateLocation(_ sender: CLLocation)
    
}

public class LocalizationHelper: NSObject {

    public weak var delegate: LocalizationHelperDelegate?
    public static var shared = LocalizationHelper()

    private lazy var locationManager: CLLocationManager = {
        let locationManager = CLLocationManager()
        locationManager.requestAlwaysAuthorization()
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.pausesLocationUpdatesAutomatically = false
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        return locationManager
    }()

    private var currentLocation: CLLocationCoordinate2D?

    public func startUpdatingLocation() {
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }

    public func stopUpdatingLocation() {
        locationManager.stopUpdatingLocation()
    }

    public func getCurrentLocation() -> CLLocationCoordinate2D? {
        return currentLocation
    }

    public func getLat() -> Double{
        return currentLocation?.latitude ?? 0.0
    }

    public func getLon() -> Double{
        return currentLocation?.longitude ?? 0.0
    }


}

extension LocalizationHelper: CLLocationManagerDelegate {

    public func locationManager(_: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        guard let location = locations.first else { return }
        currentLocation = location.coordinate
        print("[Update location at - \(Date())] with - lat: \(currentLocation!.latitude), lng: \(currentLocation!.longitude)")
        delegate?.didUpdateLocation(location)
    }
}
