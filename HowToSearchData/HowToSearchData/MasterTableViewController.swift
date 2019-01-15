//
//  MasterTableViewController.swift
//  HowToSearchData
//
//  Created by duycuong on 1/15/19.
//  Copyright © 2019 duycuong. All rights reserved.
//

import UIKit

struct Laptop {
    let catogery: String
    let name: String
    let imageView: UIImage!
}

class MasterTableViewController: UITableViewController {
    
    //MARK: Properties
    
    var laptops = [
        Laptop(catogery: "APPLE", name: "Apple Macbook 12", imageView: UIImage(named: "Apple Macbook 12")),
        Laptop(catogery: "APPLE", name: "Macbook Air 13", imageView: UIImage(named: "Macbook Air 13")),
        Laptop(catogery: "APPLE", name: "MacBook Pro 13 Retina", imageView: UIImage(named: "MacBook Pro 13 Retina")),
        Laptop(catogery: "ASUS", name: "ASUS Transformer Book", imageView: UIImage(named: "ASUS Transformer Book")),
        Laptop(catogery: "ASUS", name: "Asus Vivobook", imageView: UIImage(named: "Asus Vivobook")),
        Laptop(catogery: "DELL", name: "Dell Inspiron 3462", imageView: UIImage(named: "Dell Inspiron 3462")),
        Laptop(catogery: "DELL", name: "Dell Inspiron 3467", imageView: UIImage(named: "Dell Inspiron 3467")),
        Laptop(catogery: "DELL", name: "Dell Latitude 3480", imageView: UIImage(named: "Dell Latitude 3480")),
        Laptop(catogery: "DELL", name: "Dell Vostro 3468", imageView: UIImage(named: "Dell Vostro 3468")),
        Laptop(catogery: "OTHER", name: "Fujitsu LifeBook U938", imageView: UIImage(named: "Fujitsu LifeBook U938")),
        Laptop(catogery: "OTHER", name: "HP EliteBook 840 G1", imageView: UIImage(named: "HP EliteBook 840 G1")),
        Laptop(catogery: "OTHER", name: "LG Gram 2018", imageView: UIImage(named: "LG Gram 2018")),
        Laptop(catogery: "OTHER", name: "Microsoft Surface Pro 4", imageView: UIImage(named: "Microsoft Surface Pro 4")),
        Laptop(catogery: "OTHER", name: "Xiaomi Mi Notebook Air", imageView: UIImage(named: "Xiaomi Mi Notebook Air"))
    ]
    
    var filterLaptop = [Laptop]()
    var searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Setup for search
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Here"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        
        // Setup for Scope
        searchController.searchBar.delegate = self
        searchController.searchBar.scopeButtonTitles = ["ALL", "APPLE", "ASUS", "DELL", "OTHER"]
    }
    
    //MARK: Action
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as? DetailViewController
        
        if let indexPath = tableView.indexPathForSelectedRow {
            var laptop: Laptop
            laptop = laptops[indexPath.row]
            destination?.detailCatogeryText = laptop.catogery
            destination?.detailNameText = laptop.name
            destination?.detailImage = laptop.imageView
        }
        
    }
    
    //MARK: Setup action for Search
    func isSearchBarEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    func isFiltering() -> Bool {
        let scopeFiltering = searchController.searchBar.selectedScopeButtonIndex != 0
        return searchController.isActive && (!isSearchBarEmpty() || scopeFiltering)
    }
    
    func filterContentForSearch(_ searchText: String, scope: String = "ALL") {
        filterLaptop = laptops.filter({ (laptop: Laptop) -> Bool in
            let doesCatogeryMath = (scope == "ALL") || (laptop.catogery == scope)
            if isSearchBarEmpty() {
                return doesCatogeryMath
            } else {
                
                return doesCatogeryMath && laptop.name.lowercased().contains(searchText.lowercased())
            }
        })
        tableView.reloadData()
    }

    //MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            // return về những kết qủa tìm được
            return filterLaptop.count
        } else {
            return laptops.count
        }
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
        
        
        let laptop: Laptop
        if isFiltering() {
            laptop = filterLaptop[indexPath.row]
        } else {
            laptop = laptops[indexPath.row]
        }

        cell.catogeryLabel.text = laptop.catogery
        cell.catogeryLabel.textColor = UIColor.red
        cell.laptopLabel.text = laptop.name
        cell.laptopLabel.textColor = UIColor.darkGray
        cell.nameImageView.image = UIImage(named: laptop.name)
        
        // Set color when user touch inside (or click choose)
        let backgroundView = UIView()
        backgroundView.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        cell.selectedBackgroundView = backgroundView
        indexPath.row % 2 == 0 ? (cell.backgroundColor = #colorLiteral(red: 0.8374283536, green: 0.8986742516, blue: 0.9008055376, alpha: 0.5139194542)) : (cell.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
        
        return cell
    }


}

extension MasterTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        filterContentForSearch(searchController.searchBar.text!, scope: scope)
    }
}

extension MasterTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearch(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}
