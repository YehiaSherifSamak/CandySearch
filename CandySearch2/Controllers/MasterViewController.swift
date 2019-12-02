//
//  ViewController.swift
//  CandySearch2
//
//  Created by Yehia Samak on 11/30/19.
//  Copyright © 2019 Yehia Samak. All rights reserved.
//

import UIKit

class MasterViewController: UIViewController {

    var candies: [Candy] = [Candy]();
    let searchController = UISearchController(searchResultsController: nil)
    var filteredCandies: [Candy] = [];
    var isSearchBarEmpty: Bool {
        return searchController.searchBar.text?.isEmpty ?? true;
    }
    var isFiltering: Bool {
        return searchController.isActive && !isSearchBarEmpty;
    }
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDummyCanddiesValues();
        settingUpSearchbar();
        tableView.delegate = self;
        tableView.dataSource = self;
        searchController.searchBar.delegate = self;
    }
    func setDummyCanddiesValues(){
           candies = [
                           Candy(name: "Chocolate Bar", category: "Chocolate"),
                           Candy(name: "Chocolate Chip", category: "Chocolate"),
                           Candy(name: "Dark Chocolate", category: "Chocolate"),
                           Candy(name: "Lillipop", category: "Hard"),
                           Candy(name: "Candy Can", category: "Hard"),
                           Candy(name: "Jaw Baker", category: "Hard"),
                           Candy(name: "Caramel", category: "Other"),
                           Candy(name: "Sour Chew", category: "Other"),
                           Candy(name: "Gummi Bear", category: "Other")
                       ]
       }
    
    

}
extension MasterViewController: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0;
    }
}



extension MasterViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         if isFiltering {
          return filteredCandies.count
        }
          
        return candies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "candy_cell") as! CandyTableViewCell;
        let candy = (isFiltering) ? filteredCandies[indexPath.row] : candies[indexPath.row];
        cell.setValue(candy: candy);
        return cell;
    }
    
    
}


extension MasterViewController: UISearchResultsUpdating{
    func settingUpSearchbar(){
        searchController.searchResultsUpdater = self;
        searchController.obscuresBackgroundDuringPresentation = false;
        searchController.searchBar.placeholder = "Search Candies";
        navigationItem.searchController = searchController;
        definesPresentationContext = true;
        searchController.searchBar.scopeButtonTitles = ["All", "Chocolate", "Hard", "Other"];
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        let category = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex];
        filterContentForSearchText(searchText: searchBar.text!, category: category)
    }
    func filterContentForSearchText(searchText : String, category : String = "All"){
        
        filteredCandies = candies.filter({ (candy) -> Bool in
            let doesCatogeryMatch =  category.lowercased() == "all" || candy.category == category
            print( candy.name + "  " + String(doesCatogeryMatch))
            return doesCatogeryMatch && candy.name.lowercased().contains(searchText.lowercased());
        })
      tableView.reloadData()
    }
    
}

extension MasterViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        let category = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex];
        
        filterContentForSearchText(searchText: searchBar.text!, category: category);
    }
}
