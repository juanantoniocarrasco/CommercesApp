import UIKit

extension UIImageView {
    
    private var activityIndicator: UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = .black
        center(view: activityIndicator)
        return activityIndicator
    }
    
    func setImageFrom(_ urlString: String, completion: (() -> Void)? = nil) {
        guard let url = URL(string: urlString) else { return }
        
        let session = URLSession(configuration: .default)
        let activityIndicator = self.activityIndicator
        
        DispatchQueue.main.async {
            activityIndicator.startAnimating()
        }
        
        let downloadImageTask = session.dataTask(with: url) { (data, response, error) in
            
            guard let data else { return }
            
            DispatchQueue.main.async { [weak self] in
                var image = UIImage(data: data)
                self?.image = image
                image = nil
                completion?()
            }
            
            DispatchQueue.main.async {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
            }
            session.finishTasksAndInvalidate()
        }
        downloadImageTask.resume()
    }
}
