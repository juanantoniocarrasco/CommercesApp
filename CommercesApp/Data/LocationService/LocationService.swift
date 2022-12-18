import Foundation
import CoreLocation

protocol LocationServiceDelegate: AnyObject {
    func tracingLocation(_ currentLocation: CLLocation)
    func tracingLocationDidFailWithError(_ error: Error)
}

final class LocationService: NSObject {
    
    static let shared = LocationService()
    
    weak var delegate: LocationServiceDelegate?

    private let locationManager = CLLocationManager()
    var lastLocation: CLLocation?
    
    override init() {
        super.init()
    
        if CLLocationManager.authorizationStatus() == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        }
        
        DispatchQueue.global().async {
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
            self.locationManager.distanceFilter = 200
            self.locationManager.delegate = self
        }
    }
    
    func startUpdatingLocation() {
        print("Starting Location Updates")
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
        print("Stop Location Updates")
        locationManager.stopUpdatingLocation()
    }
    
}

// MARK: - CLLocationManagerDelegate

extension LocationService: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let lastLocation = locations.last else { return }
        
        self.lastLocation = lastLocation
        delegate?.tracingLocation(lastLocation)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        delegate?.tracingLocationDidFailWithError(error)
    }

}
