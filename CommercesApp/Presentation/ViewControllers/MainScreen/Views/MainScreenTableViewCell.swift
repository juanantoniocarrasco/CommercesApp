import UIKit

// MARK: - MainScreenTableViewCell

final class MainScreenTableViewCell: UITableViewCell {
    
    var view: MainScreenTableViewCellView = MainScreenTableViewCellView()
    
    static var identifier: String {
        .init(describing: self)
    }
    
    func configure(with model: MainScreenTableViewCellView.Model) {
        view.configure(with: model)
        setupView()
    }
    
    private func setupView() {
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        contentView.fill(with: view)
    }
}

// MARK: - MainScreenTableViewCellView

final class MainScreenTableViewCellView: UIView {
    
    struct Model {
        let category: CommerceCategory
        let distance: String
        let image: UIImage?
        let title: String
        let subtitle: String
    }
    
    // MARK: - Views
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            headerStackViewContainer,
            bodyStackView
        ])
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var headerStackViewContainer: UIView = {
        let view = UIView()
        view.fill(with: headerStackView, edges: .init(top: 8, left: 16, bottom: 8, right: 16))
        return view
    }()
    
    private lazy var headerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            iconImageView,
            UIView(),
            distanceLabel,
            rightArrowImageView
        ])
        return stackView
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
        return imageView
    }()
    
    private let distanceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 20)
        return label
    }()
    
    private let rightArrowImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "Arrow_right")?.withRenderingMode(.alwaysTemplate)
        imageView.image = image
        imageView.tintColor = .white
        imageView.heightAnchor.constraint(equalToConstant: 32).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 32).isActive = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var bodyStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            commerceImageViewContainer,
            bodyLabelsStackView,
            SpacerView(axis: .horizontal, space: 16)
        ])
        
        return stackView
    }()
    
    private lazy var commerceImageViewContainer: UIView = {
        let view = UIView()
        view.fill(with: commerceImageView, edges: .init(top: 8, left: 16, bottom: 16, right: 16))
        return view
    }()
    
    private let commerceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.heightAnchor.constraint(equalToConstant: 72).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 72).isActive = true
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var bodyLabelsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            SpacerView(axis: .vertical, space: 16),
            titleLabel,
            subtitleLabel,
            SpacerView(axis: .vertical, minimumSpace: 16)
        ])
        stackView.axis = .vertical
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .light)
        label.numberOfLines = 0
        return label
    }()
    
    // MARK: - Initialization
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    func configure(with model: Model) {
        headerStackViewContainer.backgroundColor = model.category.color
        iconImageView.image = model.category.icon
        distanceLabel.text = model.distance
        commerceImageView.image = model.image
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
    }

}

// MARK: - Private functions

private extension MainScreenTableViewCellView {
    
    func setupView() {
        fill(with: mainStackView, edges: .init(top: 8, left: 16, bottom: 8, right: 16))
        mainStackView.layer.cornerRadius = 10
        mainStackView.clipsToBounds = true
        mainStackView.backgroundColor = .white
        
        mainStackView.addShadow()
    }
    
}

