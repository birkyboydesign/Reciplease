//
//  RecipeDetailViewController.swift
//  Reciplease
//
//  Created by Birkyboy on 05/09/2021.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    // MARK: - Properties
    private let recipeView = RecipeDetailView()
    private let unFavoriteIcon = UIImage(systemName: "star")
    private let favoriteIcon = UIImage(systemName: "star.fill")
    private var isFavorite = true
    private var addToFavoriteButton: UIBarButtonItem?

    // MARK: - Lifecycle
    override func loadView() {
        view = recipeView
        view.backgroundColor = .secondarySystemBackground
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationItem()
        setDelegates()
    }

    // MARK: - Setup
    private func configureNavigationItem() {
        addToFavoriteButton = UIBarButtonItem(image: unFavoriteIcon,
                                                  style: .plain,
                                                  target: self,
                                                  action: #selector(favoriteButtonTapped))
        addToFavoriteButton?.tintColor = .systemOrange
        navigationItem.rightBarButtonItem = addToFavoriteButton
    }

    private func setDelegates() {
        recipeView.tableView.delegate = self
        recipeView.tableView.dataSource = self
    }

    // MARK: - Targets
    @objc private func favoriteButtonTapped() {
        toggleFavoriteButtonImage()
        isFavorite.toggle()
    }

    // MARK: - Update view
    private func toggleFavoriteButtonImage() {
        addToFavoriteButton?.image = isFavorite ? favoriteIcon : unFavoriteIcon
    }
}
// MARK: - TableView datasource
extension RecipeDetailViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        cell.backgroundColor = .clear
        cell.textLabel?.text = "Ingredient \(indexPath.row + 1)"
        return cell
    }
}

// MARK: - TableView Delegate
extension RecipeDetailViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView,
                   viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: RecipeDetailHeaderView.reuseIdentifier)
                as? RecipeDetailHeaderView
        else {
            return nil
        }
        view.recipeCardView.recipeNameLabel.text = "Green Curry"
        view.recipeCardView.recipeIngredientsLabel.text = "Ingredients"
        return view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return view.bounds.width * 0.9
    }
}
