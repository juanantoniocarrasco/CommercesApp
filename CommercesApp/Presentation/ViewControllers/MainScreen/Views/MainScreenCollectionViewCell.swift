import UIKit

final class MainScreenCollectionViewCell: UICollectionViewCell {
    
    static var identifier: String {
        .init(describing: self)
    }

    let view = MainScreenCollectionViewCellView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupViews() {
        contentView.backgroundColor = .clear
        backgroundColor = .clear
        contentView.fill(with: view)
    }
    
    func configure(with category: CommerceCategory, isSelected: Bool) {
        view.configure(with: category, isSelected: isSelected)
    }
    
}

final class MainScreenCollectionViewCellView: UIView {
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            imageView,
            SpacerView(axis: .horizontal, space: 8),
            titleLabel
        ])
        return stackView
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.heightAnchor.constraint(equalToConstant: 24).isActive = true
        imageView.widthAnchor.constraint(equalToConstant: 24).isActive = true
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        return label
    }()
        
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with category: CommerceCategory, isSelected: Bool = false) {
        if isSelected {
            imageView.image = category.iconWhite
            titleLabel.textColor = .white
            backgroundColor = category.color
        } else {
            imageView.image = category.iconColour
            titleLabel.textColor = category.color
            backgroundColor = .white
        }
        titleLabel.text = category.name

    }
    
    private func setupView() {
        fill(with: stackView, edges: .init(top: 6, left: 8, bottom: 6, right: 8))
        layer.cornerRadius = 10
        addShadow()
    }
}
