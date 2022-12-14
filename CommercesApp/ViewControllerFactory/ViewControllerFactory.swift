final class ViewControllerFactory {
    
    static func createMainScreenViewController() -> MainScreenViewController {
        let service = ApiService()
        let viewModel = MainScreenViewModel(service: service)
        let viewController = MainScreenViewController(viewModel: viewModel)
        
        return viewController
    }
    
    static func createDetailScreenViewController(with commerce: Commerce) -> DetailScreenViewController {
        let viewModel = DetailScreenViewModel(commerce: commerce)
        let viewController = DetailScreenViewController(viewModel: viewModel)
        
        return viewController
    }
}
