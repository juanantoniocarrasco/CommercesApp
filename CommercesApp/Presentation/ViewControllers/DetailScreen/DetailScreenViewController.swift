import UIKit
import CoreLocation
import MapKit

final class DetailScreenViewController: UIViewController {
    
    enum Section: CaseIterable {
        case image
        case location
        case info
        case about
    }

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.backgroundColor = .mainScreenBackgroundColor
        return tableView
    }()
    
    private lazy var imageViewContainer: UIView = {
        let view = UIView()
        view.fill(with: imageView, edges: .init(allEdges: 16))
        view.backgroundColor = .mainScreenBackgroundColor
        return view
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(named: "only image")
        imageView.image = image
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.heightAnchor.constraint(equalToConstant: 132).isActive = true
        return imageView
    }()
    
    private let mapView: MKMapView = {
        let mapView = MKMapView()
        mapView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        return mapView
    }()
    
    private lazy var infoViewContainer: UIView = {
        let view = UIView()
        view.fill(with: infoViewStackView, edges: .init(allEdges: 16))
        view.backgroundColor = .mainScreenBackgroundColor
        return view
    }()
    
    private lazy var infoViewStackView: UIStackView = {
        let title = UILabel()
        let subtitle = UILabel()
        let footer = UILabel()
        title.text = "title"
        subtitle.text = "subtitle"
        footer.text = "footer"
        let stackView = UIStackView(arrangedSubviews: [
            title,
            subtitle,
            footer
        ])
        stackView.axis = .vertical
        stackView.layer.cornerRadius = 10
        stackView.clipsToBounds = true
        stackView.backgroundColor = .white
        return stackView
    }()
    
    // MARK: - Properties
    
    private let viewModel: DetailScreenViewModelProtocol
    private let locationManager = CLLocationManager()

    // MARK: - Initialization
    
    init(viewModel: DetailScreenViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.fillToSafeAreaInTop(with: tableView)
        title = "Nombre del Comercio"

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupLocationManager()
    }
    
}

// MARK: - Private Functions

private extension DetailScreenViewController {
    
    func setupLocationManager() {
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        
        DispatchQueue.global().async {
            guard CLLocationManager.locationServicesEnabled() else { return }
            self.locationManager.delegate = self
            self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            self.locationManager.startUpdatingLocation()
        }
    }
    
    func render(_ location: CLLocation) {
        let coordinate = CLLocationCoordinate2D(latitude: location.coordinate.latitude,
                                                longitude: location.coordinate.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.1,
                                    longitudeDelta: 0.1)
        let region = MKCoordinateRegion(center: coordinate,
                                        span: span)
        mapView.setRegion(region,
                          animated: true)
        let pin = MKPointAnnotation()
        pin.coordinate = coordinate
        mapView.addAnnotation(pin)
        
    }
    
    func openInMapApp() {
        let commerceCoordinates = viewModel.getCommerceLocation()
        
        let destinationCoordinates = CLLocationCoordinate2D(latitude: commerceCoordinates.last!,
                                                            longitude: commerceCoordinates.first!)
        guard let sourceCoordinates = locationManager.location?.coordinate else { return }
        
        let source = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: sourceCoordinates.latitude,
                                                                                         longitude: sourceCoordinates.longitude)))
        let destination = MKMapItem(placemark: MKPlacemark(coordinate: CLLocationCoordinate2D(latitude: destinationCoordinates.latitude,
                                                                                              longitude: destinationCoordinates.longitude)))
        source.name = "Mi ubicación"
        destination.name = "comercio"
        
        MKMapItem.openMaps(
            with: [source, destination],
            launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        )
    }
}

// MARK: - CLLocationManagerDelegate

extension DetailScreenViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locValue = manager.location?.coordinate else { return }
        print("locations = \(locValue.latitude) \(locValue.longitude)")
        if let _ = locations.first {
            manager.stopUpdatingLocation()
        }
        let commerceCoordinates = viewModel.getCommerceLocation()
        let commerceLocation = CLLocation(latitude: commerceCoordinates.last!,
                                          longitude: commerceCoordinates.first!)
        render(commerceLocation)

    }
}

// MARK: - UITableViewDataSource

extension DetailScreenViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = Section.allCases[indexPath.section]
        
        switch section {
            case .image:
                let cell = UITableViewCell()
                cell.fill(with: imageViewContainer)
                return cell
            case .location:
                let cell = UITableViewCell()
                cell.fill(with: mapView)
                return cell
            case .info:
                let cell = UITableViewCell()
                cell.fill(with: infoViewContainer)
                return cell
            case .about:
                return .init()
        }
    }

    
}

// MARK: - UITableViewDelegate

extension DetailScreenViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let section = Section.allCases[section]
        
        switch section {
            case .image:
                let view = UIView()
                view.heightAnchor.constraint(equalToConstant: 1).isActive = true
                return view
                
            case .location:
                let header = SectionHeaderView(labelText: "Localización", buttonTitle: "Llévame aqui")
                header.delegate = self
                return header
                
            case .info:
                let view = UIView()
                view.heightAnchor.constraint(equalToConstant: 1).isActive = true
                return view
            case .about:
                return SectionHeaderView(labelText: "Sobre el comercio", buttonTitle: nil)
                
        }
    }
}

// MARK: - SectionHeaderViewDelegate

extension DetailScreenViewController: SectionHeaderViewDelegate {
    
    func buttonTapped() {
        openInMapApp()
    }
}
