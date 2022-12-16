final class DetailScreenViewModel: DetailScreenViewModelProtocol {
    
    private let commerce: Commerce
    
    init(commerce: Commerce) {
        self.commerce = commerce
    }
    
    func getCommerceLocation() -> [Double] {
        commerce.location
    }
}
