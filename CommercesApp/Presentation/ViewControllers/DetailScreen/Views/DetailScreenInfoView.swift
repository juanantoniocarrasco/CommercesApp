import MapKit

final class DetailScreenLocationView: UIView {
    
    // MARK: - Model
    
    struct Model {
        let title: String
        let subtitle: String
        let footer: String
        let photo: String
        let coordinate: CLLocationCoordinate2D?
    }
    
    // MARK: - Views
    
    private lazy var mainStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            SpacerView(axis: .vertical, space: 16),
            mapView,
            SpacerView(axis: .vertical, space: 16),
            containerView
        ])
        stackView.axis = .vertical
        return stackView
    }()
    
    private let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        return mapView
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.fill(with: stackView, edges: .init(allEdges: 16))
        return view
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            imageViewContainer,
            labelsStackView,
            SpacerView(axis: .horizontal, space: 16)
        ])
        stackView.backgroundColor = .white
        stackView.layer.cornerRadius = 10
        stackView.addShadow()
        return stackView
    }()
    
    private lazy var imageViewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            view.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 16),
            imageView.heightAnchor.constraint(equalToConstant: 52),
            imageView.widthAnchor.constraint(equalToConstant: 52)
        ])
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 5
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            SpacerView(axis: .vertical, space: 16),
            titleLabel,
            SpacerView(axis: .vertical, space: 8),
            subtitleLabel,
            SpacerView(axis: .vertical, space: 8),
            footerLabel,
            SpacerView(axis: .vertical, minimumSpace: 16)
        ])
        stackView.axis = .vertical
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 2
        return label
    }()
    
    private let footerLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.numberOfLines = 2
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
    
    // MARK: - Functions
    
    func configure(with model: Model) {
        titleLabel.text = model.title
        subtitleLabel.text = model.subtitle
        footerLabel.text = model.footer
        imageView.setImageFrom(model.photo)
        renderMapView(with: model.coordinate)
    }

}

// MARK: - Private Functions

private extension DetailScreenLocationView {
    
    func setupView() {
        fill(with: mainStackView)
        backgroundColor = .mainScreenBackgroundColor
    }
    
    func renderMapView(with coordinate: CLLocationCoordinate2D?) {
        guard let coordinate else { return }
        setMapRegion(with: coordinate)
        addPinToMap(in: coordinate)
    }
    
    func setMapRegion(with coordinate: CLLocationCoordinate2D) {
        let span = MKCoordinateSpan(latitudeDelta: 0.1,
                                    longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: coordinate,
                                        span: span)
        mapView.setRegion(region,
                          animated: true)
    }
    
    func addPinToMap(in coordinate: CLLocationCoordinate2D) {
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        mapView.addAnnotation(pin)
    }
}
