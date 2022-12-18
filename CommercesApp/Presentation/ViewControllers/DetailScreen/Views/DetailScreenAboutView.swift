import UIKit

final class DetailScreenAboutView: UIView {

    // MARK: - Views
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.fill(with: stackView, edges: .init(allEdges: 16))
        view.backgroundColor = .mainScreenBackgroundColor
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            labelContainerView
        ])
        stackView.backgroundColor = .white
        stackView.layer.cornerRadius = 10
        stackView.addShadow()
        return stackView
    }()
    
    private lazy var labelContainerView: UIView = {
        let view = UIView()
        view.fill(with: label, edges: .init(allEdges: 16))
        return view
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup View
    
    private func setupView() {
        fill(with: containerView)
    }
    
    func configure(with text: String) {
        label.text = text
    }
    
}
