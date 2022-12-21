import CoreLocation

protocol LocationServiceProtocol {
    var delegate: LocationServiceDelegate? { get set }
    var lastLocation: CLLocation? { get }
    func startUpdatingLocation()
    func stopUpdatingLocation()
}
