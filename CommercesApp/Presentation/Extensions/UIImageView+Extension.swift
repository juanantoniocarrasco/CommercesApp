import UIKit
import Kingfisher

extension UIImageView {
    
    private static let placeholderCommerceImage = UIImage(named: "only image")
    
    func setImageFrom(_ urlString: String) {
        let url = URL(string: urlString)
        kf.indicatorType = .activity
        kf.setImage(with: url) { result in
            switch result {
                case .success(_):
                    break
                case .failure(_):
                    DispatchQueue.main.async { [weak self] in
                        self?.image = Self.placeholderCommerceImage
                    }
            }
        }
    }
}
