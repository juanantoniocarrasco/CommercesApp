final class MainScreenViewModel: MainScreenViewModelProtocol {
    
    private let service: ApiServiceProtocol
    private var commerces: [Commerce] = []
    
    init(service: ApiServiceProtocol) {
        self.service = service
    }
    
    func viewDidLoad() {
        getCommerces()
    }
    
}

private extension MainScreenViewModel {
    
    func getCommerces() {
        service.getCommerces { [weak self] result in
            switch result {
                case .success(let commerces):
                    self?.commerces = commerces
                    
                case .failure(let error):
                    print("Error processing json data: \(error)")
            }
        }
    }
    
}
