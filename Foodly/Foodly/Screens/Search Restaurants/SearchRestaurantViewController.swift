//
//  SearchRestaurantViewController.swift
//  Foodly
//
//  Created by Decagon on 16/06/2021.
//

import UIKit

class SearchRestaurantViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var table: UITableView!
    
    @IBOutlet weak var searchTextField: UITextField!

    var filteredData: [Restaurants]!
    var searchViewModel = HomeScreenViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.register(UINib(nibName: "RestaurantsTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        table.dataSource = self
        table.delegate = self
        searchBar.delegate = self
        filteredData = searchViewModel.restaurantList
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
}

extension SearchRestaurantViewController: UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let  cell = tableView.dequeueReusableCell(withIdentifier:
                                                            "cell", for: indexPath)
                as? RestaurantsTableViewCell else {return UITableViewCell()}
        cell.setup(with: filteredData[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ = filteredData[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        guard let viewController = UIStoryboard(name: "Details", bundle: nil)
                .instantiateViewController(identifier: "DetailsVC")
                as? DetailsViewController else {return}
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    private func filterRestaurants (_ searchText: String) {
        for restaurantSearched in searchViewModel.restaurantList {
            let restaurant = restaurantSearched.restaurantName.lowercased()
            let restaurantFood = restaurantSearched.category.lowercased()
            if restaurant.contains(searchText.lowercased()) || restaurantFood.contains(searchText.lowercased()) {
                filteredData.append(restaurantSearched)
            }
        }
    }

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filteredData = []
        searchText.isEmpty ? filteredData = searchViewModel.restaurantList : filterRestaurants(searchText)
        table.reloadData()
    }
}
