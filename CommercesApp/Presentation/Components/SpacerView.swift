import UIKit

final class SpacerView: UIView {
    
    enum SpacerAxis {
        case vertical
        case horizontal
    }
    
    init(axis: SpacerAxis, space: CGFloat) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        switch axis {
            case .vertical:
                heightAnchor.constraint(equalToConstant: space).isActive = true
            case .horizontal:
                widthAnchor.constraint(equalToConstant: space).isActive = true
        }
    }
    
    init(axis: SpacerAxis, minimumSpace: CGFloat) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        switch axis {
            case .vertical:
                heightAnchor.constraint(greaterThanOrEqualToConstant: minimumSpace).isActive = true
            case .horizontal:
                widthAnchor.constraint(greaterThanOrEqualToConstant: minimumSpace).isActive = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
