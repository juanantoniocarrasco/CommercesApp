import UIKit

final class MainScreenViewModel: MainScreenViewModelProtocol {
    
    enum State {
        case commerceListLoaded(commerceList: [Commerce])
    }
    
    var state: Observable<State?> = .init(wrappedValue: nil)

    private let service: ApiServiceProtocol
    private var commerceList: [Commerce] = []
    
    init(service: ApiServiceProtocol) {
        self.service = service
    }
    
    func viewDidLoad() {
        getCommerces()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        commerceList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainScreenTableViewCell.identifier, for: indexPath) as? MainScreenTableViewCell else { return .init() }
        
        let commerce = commerceList[indexPath.row]
        cell.configure(with: .init(category: commerce.commerceCategory,
                                   distance: "250m.",
                                   image: UIImage(named: "only image"),
                                   title: commerce.name,
                                   subtitle: commerce.openingHours))
        return cell
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
    
    func getBeautyCommerces() -> [Commerce] {
        commerceList.filter({ $0.commerceCategory == .beauty })
    }
    
    func getLeisureCommerces() -> [Commerce] {
        commerceList.filter({ $0.commerceCategory == .leisure })
    }
}
