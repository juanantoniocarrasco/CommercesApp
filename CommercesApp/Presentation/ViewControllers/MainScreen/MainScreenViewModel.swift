import UIKit

final class MainScreenViewModel: MainScreenViewModelProtocol {
    
    enum State {
        case commerceListLoaded(commerceList: [Commerce])
    }
    
    var state: Observable<State?> = .init(wrappedValue: nil)

    private let service: ApiServiceProtocol
    private var commerceList: [Commerce] = []
    private var filteredCommerceList: [Commerce] = []
    
    init(service: ApiServiceProtocol) {
        self.service = service
    }
    
    func viewDidLoad() {
        getCommerces()
    }
    
    func categorySelected(_ categorySelected: CommerceCategory, isCurrentCategory: Bool) {
        if isCurrentCategory  {
            filteredCommerceList = []
            state.wrappedValue = .commerceListLoaded(commerceList: commerceList)
            return
        }
        
        var filteredCommerceList: [Commerce] = []
        switch categorySelected {
            case .gasStation:
                filteredCommerceList = getGasStationCommerces()
            case .restaurant:
                filteredCommerceList = getRestaurantCommerces()
            case .leisure:
                filteredCommerceList = getLeisureCommerces()
            case .shopping:
                filteredCommerceList = getShoppingCommerces()
            case .electricStation:
                filteredCommerceList = getElectricStationCommerces()
            case .directSales:
                filteredCommerceList = getDirectSalesCommerces()
            case .beauty:
                filteredCommerceList = getBeautyCommerces()
        }
        state.wrappedValue = .commerceListLoaded(commerceList: filteredCommerceList)
        self.filteredCommerceList = filteredCommerceList
    }
}

private extension MainScreenViewModel {
    
    func getCommerces() {
        service.getCommerces { [weak self] result in
            switch result {
                case .success(let commerceList):
                    self?.commerceList = commerceList
                    self?.state.wrappedValue = .commerceListLoaded(commerceList: commerceList)
                case .failure(let error):
                    print("Error processing json data: \(error)")
            }
        }
    }
    
    func getGasStationCommerces() -> [Commerce] {
        commerceList.filter({ $0.commerceCategory == .gasStation})
    }
    
    func getBeautyCommerces() -> [Commerce] {
        commerceList.filter({ $0.commerceCategory == .beauty })
    }
    
    func getLeisureCommerces() -> [Commerce] {
        commerceList.filter({ $0.commerceCategory == .leisure })
    }
    
    func getRestaurantCommerces() -> [Commerce] {
        commerceList.filter({ $0.commerceCategory == .restaurant })
    }
    
    func getDirectSalesCommerces() -> [Commerce] {
        commerceList.filter({ $0.commerceCategory == .directSales })
    }
    
    func getElectricStationCommerces() -> [Commerce] {
        commerceList.filter({ $0.commerceCategory == .electricStation })
    }
    
    func getShoppingCommerces() -> [Commerce] {
        commerceList.filter({ $0.commerceCategory == .shopping })
    }
    
}

// MARK: - TableViewDatasource

extension MainScreenViewModel {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        filteredCommerceList.isEmpty ? commerceList.count : filteredCommerceList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainScreenTableViewCell.identifier, for: indexPath) as? MainScreenTableViewCell else { return .init() }
        
        let commerceList = filteredCommerceList.isEmpty ? commerceList : filteredCommerceList
        
        let commerce = commerceList[indexPath.row]
        cell.configure(with: .init(category: commerce.commerceCategory,
                                   distance: "250m.",
                                   image: UIImage(named: "only image"),
                                   title: commerce.name,
                                   subtitle: commerce.openingHours))
        return cell
    }
}
