import CoreLocation

protocol LocationServiceDelegate: AnyObject {
    func tracingLocation(_ currentLocation: CLLocation)
    func tracingLocationDidFailWithError(_ error: Error)
}

final class LocationService: NSObject, LocationServiceProtocol {
    
    static let shared = LocationService()
    
    var lastLocation: CLLocation?
    weak var delegate: LocationServiceDelegate?

    private let locationManager = CLLocationManager()
    
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
        locationManager.startUpdatingLocation()
    }
    
    func stopUpdatingLocation() {
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
