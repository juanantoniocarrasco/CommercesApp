import UIKit

final class MainScreenViewController: UIViewController {
    
    // MARK: - Views
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            screenTitleView,
            SpacerView(axis: .vertical, space: 16),
            headerView,
            tableView
        ])
        stackView.axis = .vertical
        return stackView
    }()
    
    lazy var headerView: MainScreenHeaderView = {
        let view = MainScreenHeaderView()
        view.delegate = self
        return view
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MainScreenTableViewCell.self, forCellReuseIdentifier: MainScreenTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        return tableView
    }()

    lazy var screenTitleView: UIView = {
        let view = UIView()
        view.fill(with: screenTitleLabel, edges: .init(allEdges: 24))
        view.backgroundColor = .white
        return view
    }()
    
    private let screenTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Listado de comercios"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        label.textAlignment = .center
        return label
    }()
    
    private let viewModel: MainScreenViewModelProtocol
    var categorySelected: CommerceCategory?
    
    init(viewModel:MainScreenViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        view.fill(with: stackView)
        view.backgroundColor = .white.withAlphaComponent(0.95)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
        bind()
    }
    
    // MARK: - Bind
    
    private func bind() {
        viewModel.state.observe(on: self) { [weak self] state in
            guard let state else { return }
            
            switch state {
                case .commerceListLoaded(let commerceList):
                    self?.headerView.configure(with: commerceList)
                    self?.updateTableView()
            }
        }
    }

}

// MARK: - Private Functions

private extension MainScreenViewController {
    
    func updateTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension MainScreenViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.tableView(tableView, numberOfRowsInSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = viewModel.tableView(tableView, cellForRowAt: indexPath)
        
        return cell
    }
    
    
}

extension MainScreenViewController: UITableViewDelegate {
    
}

extension MainScreenViewController: MainScreenHeaderViewDelegate {
    
    func categorySelected(_ categorySelected: CommerceCategory) {
        self.categorySelected = categorySelected
        viewModel.categorySelected(categorySelected)
    }
}
