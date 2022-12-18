import UIKit

protocol DetailScreenSectionHeaderViewDelegate: AnyObject {
    func buttonTapped()
}

final class DetailScreenSectionHeaderView: UIView {
    
    // MARK: - Views
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            label,
            UIView(),
            button
        ])
        stackView.layer.cornerRadius = 10
        return stackView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.text = "Localización"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        return label
    }()
    
    private lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Llévame aquí", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: DetailScreenSectionHeaderViewDelegate?
    
    // MARK: - Init
    
    init(labelText: String?, buttonTitle: String? = nil) {
        super.init(frame: .zero)
        setupView()
        label.text = labelText
        
        if let buttonTitle {
            button.setTitle(buttonTitle, for: .normal)
        } else {
            button.isHidden = true
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    
    private func setupView() {
        fill(with: stackView, edges: .init(top: 0, left: 16, bottom: 0, right: 16))
        backgroundColor = .clear

    }
    
    @objc
    private func buttonTapped() {
        delegate?.buttonTapped()
    }
}
