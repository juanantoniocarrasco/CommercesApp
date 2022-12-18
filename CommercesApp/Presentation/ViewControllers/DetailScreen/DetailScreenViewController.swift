import MapKit

final class DetailScreenViewController: UIViewController {
    
    enum Section: CaseIterable {
        case image
        case location
        case about
    }

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
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
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.heightAnchor.constraint(equalToConstant: 132).isActive = true
        return imageView
    }()
    
    private let locationView: DetailScreenLocationView = {
        let view = DetailScreenLocationView()
        return view
    }()
    
    private let aboutView: DetailScreenAboutView = {
        let view = DetailScreenAboutView()
        return view
    }()
    
    // MARK: - Properties
    
    private let viewModel: DetailScreenViewModelProtocol
    private let locationService = LocationService.shared

    // MARK: - Initialization
    
    init(viewModel: DetailScreenViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func loadView() {
        super.loadView()
        setupLocationService()
        setupUI()
        bind()
        viewModel.viewDidLoad()
    }

}

// MARK: - Private Functions

private extension DetailScreenViewController {
    
    func setupUI() {
        view.backgroundColor = .white
        view.fillToSafeAreaInTop(with: tableView)
    }
    
    func bind() {
        viewModel.state.observe(on: self) { [weak self] state in
            guard let state else { return }
            
            switch state {
                case .loaded(let commerce):
                    self?.title = commerce.name
                    self?.imageView.setImageFrom(commerce.photo)
                    if let model = self?.getModelForLocationView(for: commerce) {
                        self?.locationView.configure(with: model)
                    }
                    if let aboutText = self?.getModelForAboutView(for: commerce) {
                        self?.aboutView.configure(with: aboutText)
                    }
                    self?.updateTableView()
                case .locationButtonTapped(let commerce):
                    self?.openInMapApp(commerce)
            }
        }
    }
    
    func getModelForAboutView(for commerce: Commerce) -> String {
        let firstText = commerce.openingHours.isEmpty
        ? "Horario no disponible para este comercio"
        : commerce.openingHours
        
        guard
            let cashback = commerce.cashback,
            cashback != 0
        else {
            return firstText
        }
        
        let secondText = "Hasta \(Int(cashback))% de saldo por cada compra"
       
        return firstText + "\n\n" + secondText
    }
    
    func getModelForLocationView(for commerce: Commerce) -> DetailScreenLocationView.Model {
        .init(title: commerce.name + " " + commerce.address.street,
              subtitle: commerce.address.city + ", " + (commerce.address.state ?? "").capitalized + ", " + (commerce.address.zip ?? ""),
              footer: commerce.address.country.capitalized,
              photo: commerce.photo,
              coordinate: commerce.locationCoordinate)
    }
    
    func setupLocationService() {
        locationService.startUpdatingLocation()
    }
    
    func openInMapApp(_ commerce: Commerce) {
        guard
            let sourceCoordinate = locationService.lastLocation?.coordinate,
            let destinationCoordinate = commerce.locationCoordinate
        else {
            return
        }
        let source = MKMapItem(placemark: MKPlacemark(coordinate: sourceCoordinate))
        let destination = MKMapItem(placemark: MKPlacemark(coordinate: destinationCoordinate))
        source.name = "Mi ubicación"
        destination.name = commerce.name
        
        MKMapItem.openMaps(with: [source, destination],
                           launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
    }
    
    func updateTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
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
                cell.selectionStyle = .none
                return cell

            case .location:
                let cell = UITableViewCell()
                cell.fill(with: locationView)
                cell.selectionStyle = .none
                return cell
                
            case .about:
                let cell = UITableViewCell()
                cell.fill(with: aboutView)
                cell.selectionStyle = .none
                return cell
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
                let header = DetailScreenSectionHeaderView(labelText: "Localización",
                                                           buttonTitle: "Llévame aqui")
                header.delegate = self
                return header
                
            case .about:
                return DetailScreenSectionHeaderView(labelText: "Sobre el comercio")
                
        }
    }
}

// MARK: - SectionHeaderViewDelegate

extension DetailScreenViewController: DetailScreenSectionHeaderViewDelegate {
    
    func buttonTapped() {
        viewModel.locationButtonTapped()
    }
}
