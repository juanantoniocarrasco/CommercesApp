import UIKit

final class SpinnerViewController: UIViewController {
    
    private let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    
    override func loadView() {
        view = UIView()
        view.backgroundColor = .white.withAlphaComponent(0.2)
        spinner.startAnimating()
        view.fillToSafeAreaInTop(with: spinner)
    }
}
