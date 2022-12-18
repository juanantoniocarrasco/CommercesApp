import CoreLocation

extension Commerce {
    
    var locationCoordinate: CLLocationCoordinate2D? {
        guard
            let latitude = location.last,
            let longitude = location.first
        else {
            return nil
        }
        return .init(latitude: latitude,
                     longitude: longitude)
    }
    
}
