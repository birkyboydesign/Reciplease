//
//  TableViewController.swift
//  Reciplease
//
//  Created by Birkyboy on 05/09/2021.
//

import UIKit

class RecipeTableViewController: UITableViewController {

    // MARK: - Properties
    private let cellIndentifier = RecipeTableViewCell.reuseIdentifier
    private var recipeListType: RecipeListType
    private let recipeListEmptyStateView = RecipeTableViewEmptyStateView()

    init(recipeListType: RecipeListType) {
        self.recipeListType = recipeListType
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .secondarySystemBackground
        addKeyboardDismissGesture()
        configureTableView()
        configureSearchController()
     //   setEmptyStateViewConstraints()
    }

    // MARK: - Setup
    private func configureTableView() {
        self.tableView.register(RecipeTableViewCell.self, forCellReuseIdentifier: cellIndentifier)
        self.tableView.rowHeight = 170
        self.tableView.separatorStyle = .none
    }

    private func configureSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.automaticallyShowsSearchResultsController = true
        searchController.searchBar.placeholder = "Search recipe"
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = true
    }

    // MARK: - TableView
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     //   displayEmptyStateView(false)
        return recipeListType == .favorite ? 10 : 3
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
                withIdentifier: cellIndentifier,
                for: indexPath
        ) as? RecipeTableViewCell else {
            return UITableViewCell()
        }
        cell.configure()
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipeDetailVC = RecipeDetailViewController()
        navigationController?.pushViewController(recipeDetailVC, animated: true)
    }
}

// MARK: - Search result updater
extension RecipeTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {

    }
}
