//
//  SchoolListViewController.swift
//  20220604-AaronStephens-NYCSchools
//
//  Created by Aaron Stephens on 6/6/22.
//

import UIKit

class SchoolListViewController: UIViewController {

	@IBOutlet weak var tableView: UITableView!

	var viewModel: SchoolListViewModel! = SchoolListViewModel()

	override func viewDidLoad() {
		super.viewDidLoad()

		self.navigationItem.title = "NYC High Schools"

		viewModel.addObserver { [weak self] in
			self?.tableView.reloadData()
		}
	}

	deinit {
		viewModel = nil
	}
}


// MARK: -
extension SchoolListViewController: UITableViewDataSource, UITableViewDelegate {

	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}

	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return viewModel.schoolList.count
	}

	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "listCell")!
		cell.textLabel!.text = viewModel.schoolList[indexPath.row].schoolName
		return cell
	}

	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		if let navigationController = self.navigationController {
			viewModel.rowSelected(navigationController: navigationController, index: indexPath.row)
		}

		tableView.deselectRow(at: indexPath, animated: true)
	}
}
