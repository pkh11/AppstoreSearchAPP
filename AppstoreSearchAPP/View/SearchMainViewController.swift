//
//  SearchMainViewController.swift
//  AppstoreSearchAPP
//
//  Created by 박균호 on 2020/09/16.
//  Copyright © 2020 pkh. All rights reserved.
//

import UIKit

class SearchMainViewController: UIViewController {
   
    @IBOutlet var keywordTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        keywordTableView.delegate = self
        keywordTableView.dataSource = self
        
        let searchResultsViewController = SearchResultsViewController()
        let searchController = UISearchController(searchResultsController: searchResultsViewController)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "App Store"

        self.navigationItem.searchController = searchController
        self.definesPresentationContext = true
        
    }
    
}
extension SearchMainViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
extension SearchMainViewController: UITableViewDelegate, UITableViewDataSource {
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "keywordTableViewCell") as! KeywordTableViewCell
        cell.keyword.text = "카트라이더"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: "keywordHeaderCell") as! KeywordHeaderCell
        header.headerTitle.text = "최근 검색어"
        
        return header
    }
}
