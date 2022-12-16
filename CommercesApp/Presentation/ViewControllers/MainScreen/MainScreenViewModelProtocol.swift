import UIKit

protocol MainScreenViewModelProtocol {
    var state: Observable<MainScreenViewModel.State?> { get }
    func viewDidLoad()
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    func categorySelected(_ categorySelected: CommerceCategory, isCurrentCategory: Bool)
}
