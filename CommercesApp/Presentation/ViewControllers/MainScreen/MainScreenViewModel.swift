import UIKit
import CoreLocation

final class MainScreenViewModel: MainScreenViewModelProtocol {
    
    enum State {
        case commerceListLoaded(commerceList: [Commerce])
        case tableCellSelected(for: Commerce)
    }
    
    var state: Observable<State?> = .init(wrappedValue: nil)

    private let apiService: ApiServiceProtocol
    private let locationService: LocationServiceProtocol

    private var commerceList: [Commerce] = []
    private var filteredCommerceList: [Commerce] = []

    init(apiService: ApiServiceProtocol,
         locationService: LocationServiceProtocol) {
        self.apiService = apiService
        self.locationService = locationService
    }
    
    func viewDidLoad() {
        setupLocationService()
    }
    
    func categorySelected(_ categorySelected: CommerceCategory,
                          isCurrentCategory: Bool) {
        if isCurrentCategory {
            filteredCommerceList = []
            state.wrappedValue = .commerceListLoaded(commerceList: commerceList)
            return
        }
        filteredCommerceList = getCommerces(forCategory: categorySelected)
        state.wrappedValue = .commerceListLoaded(commerceList: filteredCommerceList)
    }
}

// MARK: - Private Functions

private extension MainScreenViewModel {
    
    func setupLocationService() {
        locationService.startUpdatingLocation()
    }
    
    func getCommerces() {
        apiService.getCommerces { [weak self] result in
            switch result {
                case .success(let commerceList):
                    guard let commerceListSorted = self?.getCommerceListSorted(commerceList: commerceList) else { return }
                    self?.commerceList = commerceListSorted
                    self?.state.wrappedValue = .commerceListLoaded(commerceList: commerceListSorted)
                    
                case .failure(_):
                    break
                    // TODO: Handle error
            }
        }
    }
    
    func getCommerceListSorted(commerceList: [Commerce]) -> [Commerce] {
        guard let userLocation = locationService.lastLocation else { return commerceList }
        
        return commerceList
            .compactMap { commerce in
                guard let distance = getCommerceDistanceToUser(commerce: commerce,
                                                               userLocation: userLocation) else { return nil }
                return commerce.updateDistanceToUser(distance)
            }.sorted {
                $0.distanceToUser! < $1.distanceToUser!
            }
    }
    
    func getCommerceDistanceToUser(commerce: Commerce,
                                   userLocation: CLLocation) -> Double? {
        guard let commerceCoordinate = commerce.locationCoordinate else { return nil }
        
        let commerceLocation = CLLocation(latitude: commerceCoordinate.latitude,
                                          longitude: commerceCoordinate.longitude)
        let distance = userLocation.distance(from: commerceLocation) / 1000
        return distance
    }
    
    func getCommerces(forCategory category: CommerceCategory) -> [Commerce] {
        commerceList.filter { $0.commerceCategory == category }
    }

    func getRoundedDistanceInString(distance: Double?) -> String? {
        guard let distance else { return nil }
        
        let roundedDistance = Double(round(10 * distance) / 10)
        let distanceString = "\(roundedDistance) km"
        
        return distanceString
    }
}

// MARK: - TableViewDatasource

extension MainScreenViewModel {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredCommerceList.isEmpty
        ? commerceList.count
        : filteredCommerceList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainScreenTableViewCell.identifier,
                                                     for: indexPath) as? MainScreenTableViewCell else { return .init() }
        
        let commerceList = filteredCommerceList.isEmpty
        ? commerceList
        : filteredCommerceList
        
        let commerce = commerceList[indexPath.row]
        let distance = getRoundedDistanceInString(distance: commerce.distanceToUser)
                
        cell.configure(with: .init(category: commerce.commerceCategory,
                                   distance: distance,
                                   photo: commerce.photo,
                                   title: commerce.name,
                                   bodyTitle: commerce.address.street,
                                   bodySubtitle: commerce.openingHours))
        return cell
    }

}

// MARK: - TableViewDelegate

extension MainScreenViewModel {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)  {
        let commerceList = filteredCommerceList.isEmpty
        ? commerceList
        : filteredCommerceList
        
        let commerce = commerceList[indexPath.row]
        state.wrappedValue = .tableCellSelected(for: commerce)
    }
}

// MARK: - LocationServiceDelegate

extension MainScreenViewModel: LocationServiceDelegate {
    
    func tracingLocation(_ currentLocation: CLLocation) {
        getCommerces()
    }
    
    func tracingLocationDidFailWithError(_ error: Error) {
        // TODO: Handle error
    }
    
}
