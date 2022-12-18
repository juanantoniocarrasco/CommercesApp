final class DetailScreenViewModel: DetailScreenViewModelProtocol {
    
    enum State {
        case loaded(commerce: Commerce)
        case locationButtonTapped(commerce: Commerce)
    }
    
    var state: Observable<State?> = .init(wrappedValue: nil)
    
    private let commerce: Commerce
    
    init(commerce: Commerce) {
        self.commerce = commerce
    }
    
    func viewDidLoad() {
        state.wrappedValue = .loaded(commerce: commerce)
    }
    
    func locationButtonTapped() {
        state.wrappedValue = .locationButtonTapped(commerce: commerce)
    }

}
