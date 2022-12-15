import UIKit

protocol MainScreenHeaderViewDelegate: AnyObject {
    
}

final class MainScreenHeaderView: UIView {
    
    // MARK: - Views
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            horizontalStackView,
            collectionView
        ])
        stackView.axis = .vertical
        stackView.spacing = 16
        return stackView
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
    
    let leftInfoView: InfoView = {
        let view = InfoView(style: .dark)
        return view
    }()
    
    let rightInfoView: InfoView = {
        let view = InfoView(style: .light)
        return view
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.heightAnchor.constraint(equalToConstant: 48).isActive = true
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    init() {
        super.init(frame: .zero)
        fill(with: mainStackView, edges: .init(allEdges: 16))
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

    }
    
    private func getNumberOfCommercesLessThanAKm(for commerceList: [Commerce]) -> String {
        "10"
    }
}

extension MainScreenHeaderView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        CommerceCategory.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath as IndexPath) as UICollectionViewCell
        
        cell.backgroundColor = .white
        return cell
    }
    
}

extension MainScreenHeaderView: UICollectionViewDelegate {
    
}
