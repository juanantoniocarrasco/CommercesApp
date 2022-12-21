import CoreLocation

final class DetailScreenViewModel: DetailScreenViewModelProtocol {
    
    enum State {
        case loaded(commerce: Commerce)
        case locationButtonTapped(commerce: Commerce, lastLocation: CLLocation?)
    }
    
    var state: Observable<State?> = .init(wrappedValue: nil)
    
    private let commerce: Commerce
    private let locationService: LocationServiceProtocol

    
    init(commerce: Commerce,
         locationService: LocationServiceProtocol) {
        self.commerce = commerce
        self.locationService = locationService
    }
    
    func viewDidLoad() {
        setupLocationService()
        state.wrappedValue = .loaded(commerce: commerce)
    }
    
    func locationButtonTapped() {
        state.wrappedValue = .locationButtonTapped(commerce: commerce, lastLocation: locationService.lastLocation)
    }

    func setupLocationService() {
        locationService.startUpdatingLocation()
    }
}
