import UIKit

final class MainScreenInfoView: UIView {
    
    enum Style {
        case light
        case dark
    }
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            titleLabel,
            subtitleLabel
        ])
        stackView.axis = .vertical
        stackView.spacing = 4
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28)
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    init(style: Style) {
        super.init(frame: .zero)
        setupView(with: style)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(withTitle title: String, subtitle: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
    
    private func setupView(with style: Style) {
        fill(with: stackView, edges: .init(allEdges: 16))
        layer.cornerRadius = 10
        addShadow()
    
        switch style {
            case .light:
                titleLabel.textColor = .orange
                subtitleLabel.textColor = .lightGray
                backgroundColor = .white
            case .dark:
                titleLabel.textColor = .white
                subtitleLabel.textColor = .white
                backgroundColor = .infoViewDarkColor
        }
    }

}
