//
//  ViewController.swift
//  FavouriteRestaurants
//
//  Created by Serhat Sezer on 08/08/2017.
//  Copyright © 2017 Serhat Sezer. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class RestaurantListController: BaseController {
    
    // IB Outlets
    @IBOutlet weak var restaurantsTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var floatingButton: FloatingButton!
    
    let disposeBag = DisposeBag()
    
    // ViewModels
    var dataSource: RestaurantListDataSource!
    
    // Transition
    let transition = CircularTransition()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set delegate and datasource and configure cells.
        configureTableView()
        // call web service depending on need (viewWillAppear or viewDidAppear)
        callWebService()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
            return
        }
        
        switch identifier {
        case "RestaurantFilterController":
            let filterController = segue.destination as! RestaurantFilterController
            filterController.filterDelegate = self
            filterController.transitioningDelegate = self
            filterController.modalPresentationStyle = .custom
        case "RestaurantDetailController":
            if let navTopItem = segue.destination as? RestaurantDetailController {
                navTopItem.restaurantViewModel = dataSource.item(at: restaurantsTableView.indexPathForSelectedRow!)
            }
           
        default:
            break
        }
    }
}

extension RestaurantListController {
    
    func callWebService() {
        
        // just change the path attribute to give meaningfull error message.
        WebServiceManager.shared.getRestaurants(path: "restaurants", completion: { restaurants in
            
            // After getting all item from server or local sort them using helper struct.
            Sorting.sort(type: .open, dataSource: restaurants, completion: { sortedItems in
                
                dataSource = RestaurantListDataSource(items: sortedItems)
                self.restaurantsTableView.reloadData()
            })

        }) { serviceError in
            
            // If there is an error send to server logger
            let serviceLogger = WebServiceLogger.shared.log(file: String(describing:self),
                                                            line: (#line),
                                                            message: serviceError.description)
            serviceLogger.subscribe(onNext: { data in
                if let data = data as? Data {
                    let message = String(data: data, encoding: .utf8)!
                    print("eror message sent \(message)")
                    let alert = UIAlertController.showAlert(message: message, buttonTitle: "Okay")
                    self.present(alert, animated: true, completion: nil)
                }
            }, onError: { error in
                print(error)
            }, onCompleted: {
                print("completed")
            }, onDisposed: {
                print("disposed")
            }).addDisposableTo(disposeBag)
        }
    }
    
    func configureTableView() {
        restaurantsTableView.delegate = self
        restaurantsTableView.dataSource = self
        restaurantsTableView.rowHeight = UITableViewAutomaticDimension
        restaurantsTableView.estimatedRowHeight = RestaurantListCell.defaultHeight
        searchBar.delegate = self
    }
}

// MARK: - TableView DataSource
extension RestaurantListController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RestaurantListCell.cellID, for: indexPath) as! RestaurantListCell
        cell.restaurantViewModel = dataSource.item(at: indexPath)
        return cell
    }
}

extension RestaurantListController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - SearchBar Delegate
extension RestaurantListController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        let searchedArr = restaurants.filter { restaurant -> Bool in
//            return restaurant.name.lowercased().contains(searchText.lowercased())
//        }
//        predicatedRestaurants  = searchText.isEmpty ? restaurants : searchedArr
//        restaurantsTableView.reloadData()
    }
}

// MARK: - Restaurant Filter Delegate
extension RestaurantListController: RestaurantFilterControllerDelegate {
    func filterItemSelected(item: FilterItem) {
        Sorting.sort(type: item.filterType, dataSource: dataSource.restaurants, completion: { sortedItems in
            dataSource.restaurants = sortedItems
            self.restaurantsTableView.reloadData()
        })
    }
}

// MARK: - Animation Transition
extension RestaurantListController: UIViewControllerTransitioningDelegate {
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        transition.startingPoint = floatingButton.center
        transition.circleColor = floatingButton.backgroundColor!
        return transition
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .present
        transition.startingPoint = floatingButton.center
        transition.circleColor = floatingButton.backgroundColor!
        return transition
    }
    
}

