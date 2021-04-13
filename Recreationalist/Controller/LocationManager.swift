//
//  MapView.swift
//  Recreationalist
//
//  Created by Katrina Curro on 4/9/21.
//
import Foundation
import CoreLocation
import Combine

class LocationManager: NSObject, ObservableObject {
    private let locationManager = CLLocationManager()
    @Published var location: CLLocation? = nil

        override init() {
            super.init()
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            //self.locationManager.distanceFilter = kCLDistanceFilterNone
            self.locationManager.requestWhenInUseAuthorization()
            self.locationManager.startUpdatingLocation()
        }

        /*@Published var locationStatus: CLAuthorizationStatus? {
            willSet {
                objectWillChange.send()
            }
        }*/

        /*@Published var lastLocation: CLLocation? {
            willSet {
                objectWillChange.send()
            }
        }*/

        /*var statusString: String {
            guard let status = locationStatus else {
                return "unknown"
            }

            switch status {
            case .notDetermined: return "notDetermined"
            case .authorizedWhenInUse: return "authorizedWhenInUse"
            case .authorizedAlways: return "authorizedAlways"
            case .restricted: return "restricted"
            case .denied: return "denied"
            default: return "unknown"
            }

        }*/
    

        //let objectWillChange = PassthroughSubject<Void, Never>()
}

    extension LocationManager: CLLocationManagerDelegate {

        /*func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            self.locationStatus = status
            print(#function, statusString)
        }*/

        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.last else {
                return
            }
            self.location = location
            print("last location in user location \(location)")
        }

    }
