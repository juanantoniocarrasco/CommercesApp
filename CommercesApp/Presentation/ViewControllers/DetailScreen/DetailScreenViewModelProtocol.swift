protocol DetailScreenViewModelProtocol {
    var state: Observable<DetailScreenViewModel.State?> { get }
    
    func viewDidLoad()
    func locationButtonTapped()
}
