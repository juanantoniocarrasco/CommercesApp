import UIKit

extension UIView {
    
    func fill(with view: UIView, edges: UIEdgeInsets = .zero) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(equalTo: topAnchor, constant: edges.top),
            view.leadingAnchor.constraint(equalTo: leadingAnchor, constant: edges.left),
            view.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -edges.right),
            view.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -edges.bottom)
        ])
    }
    
    func center(view: UIView, verticalSpacing: CGFloat = 0, horizontalSpacing: CGFloat = 0) {
        view.translatesAutoresizingMaskIntoConstraints = false
        addSubview(view)
        NSLayoutConstraint.activate([
            view.centerXAnchor.constraint(equalTo: centerXAnchor),
            view.centerYAnchor.constraint(equalTo: centerYAnchor),
            view.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, constant: -horizontalSpacing),
            view.heightAnchor.constraint(lessThanOrEqualTo: heightAnchor, constant: -verticalSpacing)
        ])
    }
    
}
