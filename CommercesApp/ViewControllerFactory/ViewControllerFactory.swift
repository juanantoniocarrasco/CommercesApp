final class ViewControllerFactory {
    
    static func createMainScreenViewController() -> MainScreenViewController {
        let apiService = ApiService()
        let locationService = LocationService.shared
        let viewModel = MainScreenViewModel(apiService: apiService,
                                            locationService: locationService)
        locationService.delegate = viewModel
        let viewController = MainScreenViewController(viewModel: viewModel)
        
        return viewController
    }
    
    static func createDetailScreenViewController(with commerce: Commerce) -> DetailScreenViewController {
        let viewModel = DetailScreenViewModel(commerce: commerce,
                                              locationService: LocationService.shared)
        let viewController = DetailScreenViewController(viewModel: viewModel)
        
        return viewController
    }
}
