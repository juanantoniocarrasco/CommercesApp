import UIKit

protocol MainScreenHeaderViewDelegate: AnyObject {
    var categorySelected: CommerceCategory? { get }
    func categorySelected(_ categorySelected: CommerceCategory)
}

final class MainScreenHeaderView: UIView {
    
    // MARK: - Views
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            horizontalStackViewContainer,
            collectionView
        ])
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
    }()
    
    private lazy var horizontalStackViewContainer: UIView = {
        let view = UIView()
        view.fill(with: horizontalStackView, edges: .init(top: 0, left: 16, bottom: 0, right: 16))
        return view
    }()
    
    private lazy var horizontalStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            leftInfoView,
            rightInfoView
        ])
        stackView.spacing = 16
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let leftInfoView: InfoView = {
        let view = InfoView(style: .dark)
        return view
    }()
    
    private let rightInfoView: InfoView = {
        let view = InfoView(style: .light)
        return view
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.sectionInset = .init(top: 0, left: 16, bottom: 0, right: 16)
        layout.invalidateLayout()
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MainScreenCollectionViewCell.self, forCellWithReuseIdentifier: MainScreenCollectionViewCell.identifier)
        collectionView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false

        return collectionView
    }()
    
    weak var delegate: MainScreenHeaderViewDelegate?
    
    init() {
        super.init(frame: .zero)
        fill(with: mainStackView, edges: .init(top: 16, left: 0, bottom: 16, right: 0))
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with commerceList: [Commerce]) {
        let leftInfoViewTitle = String(commerceList.count)
        let rightInfoViewTitle = getNumberOfCommercesLessThanAKm(for: commerceList)
        leftInfoView.configure(withTitle: leftInfoViewTitle,
                               subtitle: "Comercios")
        rightInfoView.configure(withTitle: rightInfoViewTitle,
                                subtitle: "A menos de 1 km")
        updateCollectionView()

    }
    
}

// MARK: - Private Functions

private extension MainScreenHeaderView {
    
    func updateCollectionView() {
        DispatchQueue.main.async { [weak self] in
            self?.collectionView.reloadData()
        }
    }
    
    func getNumberOfCommercesLessThanAKm(for commerceList: [Commerce]) -> String {
        "10"
    }
}

extension MainScreenHeaderView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        CommerceCategory.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MainScreenCollectionViewCell.identifier, for: indexPath as IndexPath) as? MainScreenCollectionViewCell else { return .init() }
    
        let category = CommerceCategory.allCases[indexPath.row]
        let isSelected = category == delegate?.categorySelected
        cell.configure(with: category, isSelected: isSelected)
        return cell
    }
    
}

extension MainScreenHeaderView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let categorySelected = CommerceCategory.allCases[indexPath.row]
        delegate?.categorySelected(categorySelected)
        
    }
}

