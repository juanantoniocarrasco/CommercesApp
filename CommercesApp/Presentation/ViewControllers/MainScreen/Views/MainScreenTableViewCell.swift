import UIKit

// MARK: - MainScreenTableViewCell

final class MainScreenTableViewCell: UITableViewCell {
    
    var view = MainScreenTableViewCellView()
    
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
        selectionStyle = .none
        addShadow()
    }
}

// MARK: - MainScreenTableViewCellView

final class MainScreenTableViewCellView: UIView {
    
    // MARK: - Model
    
    struct Model {
        let category: CommerceCategory
        let distance: String?
        let photo: String
        let title: String
        let bodyTitle: String
        let bodySubtitle: String
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
        view.fill(with: headerStackView, edges: .init(allEdges: 8))
        return view
    }()
    
    private lazy var headerStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            iconImageView,
            SpacerView(axis: .horizontal, space: 4),
            titleLabel,
            SpacerView(axis: .horizontal, minimumSpace: 4),
            distanceLabel,
            SpacerView(axis: .horizontal, space: 4),
            rightArrowImageView
        ])
        stackView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        return stackView
    }()
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.widthAnchor.constraint(equalToConstant: 28).isActive = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        return label
    }()
    
    private let distanceLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .boldSystemFont(ofSize: 16)        
        return label
    }()
    
    private let rightArrowImageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "Arrow_right")?.withRenderingMode(.alwaysTemplate)
        imageView.image = image
        imageView.tintColor = .white
        imageView.widthAnchor.constraint(equalToConstant: 20).isActive = true
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
            bodyTitleLabel,
            SpacerView(axis: .vertical, space: 4),
            bodySubtitleLabel,
            SpacerView(axis: .vertical, minimumSpace: 16)
        ])
        stackView.axis = .vertical
        return stackView
    }()
    
    private let bodyTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.font = .boldSystemFont(ofSize: 14)
        return label
    }()
    
    private let bodySubtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 2
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
        iconImageView.image = model.category.iconWhite
        distanceLabel.text = model.distance
        titleLabel.text = model.title
        bodyTitleLabel.text = model.bodyTitle
        setupBodySubtitleLabel(with: model.bodySubtitle)
        setupCommerceImage(icon: model.category.iconColour, photo: model.photo)
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
    
    func setupCommerceImage(icon: UIImage?, photo: String) {
        commerceImageView.image = icon
        commerceImageView.setImageFrom(photo)
    }
    
    func setupBodySubtitleLabel(with text: String) {
        guard
            !text.isEmpty
        else {
            bodySubtitleLabel.text = "Horario no disponible para este comercio"
            return
        }
        bodySubtitleLabel.text = "Horario: \(text)"
        
    }
}

