import UIKit

final class MainScreenViewController: UIViewController {
    
    // MARK: - Views
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [
            SpacerView(axis: .vertical, space: 16),
            headerView,
            tableView
        ])
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var headerView: MainScreenHeaderView = {
        let view = MainScreenHeaderView()
        view.delegate = self
        return view
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MainScreenTableViewCell.self,
                           forCellReuseIdentifier: MainScreenTableViewCell.identifier)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .mainScreenBackgroundColor
        return tableView
    }()
    
    private let spinnerViewController = SpinnerViewController()
    
    // MARK: - Properties
    
    var currentCategory: CommerceCategory?

    private let viewModel: MainScreenViewModelProtocol

    // MARK: - Initialization
    
    init(viewModel:MainScreenViewModelProtocol) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        setupUI()
        bind()
        showSpinner()
        viewModel.viewDidLoad()
    }

}

// MARK: - Private Functions

private extension MainScreenViewController {
    
    func setupUI() {
        view.fillToSafeAreaInTop(with: stackView)
        view.backgroundColor = .white
        title = "Listado de comercios"
        navigationItem.backBarButtonItem = .init(title: "",
                                                 style: .plain,
                                                 target: nil,
                                                 action: nil)
    }
    
    func bind() {
        viewModel.state.observe(on: self) { [weak self] state in
            guard let state,
                  let self else { return }

            switch state {
                case .commerceListLoaded(let commerceList):
                    self.headerView.configure(with: commerceList)
                    self.updateTableView()
                    self.removeSpinner()
                case .tableCellSelected(for: let commerce):
                    self.navigateToDetailScreen(with: commerce)
            }
        }
    }
    
    func updateTableView() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }

    func showSpinner() {
        addChild(spinnerViewController)
        spinnerViewController.view.frame = view.frame
        view.fillToSafeAreaInTop(with: spinnerViewController.view)
        spinnerViewController.didMove(toParent: self)
    }
    
    func removeSpinner() {
        spinnerViewController.willMove(toParent: nil)
        spinnerViewController.view.removeFromSuperview()
        spinnerViewController.removeFromParent()
    }
    
    func scrollToTop() {
        let topRow = IndexPath(row: 0, section: 0)
        tableView.scrollToRow(at: topRow,
                              at: .top,
                              animated: false)
    }
    
    func navigateToDetailScreen(with commerce: Commerce) {
        let viewController = ViewControllerFactory.createDetailScreenViewController(with: commerce)
        navigationController?.pushViewController(viewController, animated: true)
    }
}

// MARK: - UITableViewDataSource

extension MainScreenViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.tableView(tableView, numberOfRowsInSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModel.tableView(tableView, cellForRowAt: indexPath)
    }
    
}

// MARK: - UITableViewDelegate

extension MainScreenViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {        
        viewModel.tableView(tableView, didSelectRowAt: indexPath)
    }
}

// MARK: - MainScreenHeaderViewDelegate

extension MainScreenViewController: MainScreenHeaderViewDelegate {
    
    func categorySelected(_ categorySelected: CommerceCategory) {
        let isCurrentCategory = categorySelected == currentCategory
        viewModel.categorySelected(categorySelected,
                                   isCurrentCategory: isCurrentCategory)
        currentCategory = isCurrentCategory
        ? nil
        : categorySelected
        scrollToTop()
    }
}
