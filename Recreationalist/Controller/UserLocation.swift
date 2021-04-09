//
//  MapView.swift
//  Recreationalist
//
//  Created by Katrina Curro on 4/9/21.
//
import Foundation
import CoreLocation
import Combine

class UserLocation: NSObject, ObservableObject, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()
    @Published var locationStatus: CLAuthorizationStatus?
    @Published var lastLocation: CLLocation?
    @Published var myLocation: CLLocationCoordinate2D?

    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }

    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        lastLocation = location
        myLocation = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
        print(#function, location)
        print("Lat: \(location.coordinate.latitude) and long: \(location.coordinate.longitude)")
    }
    
}
