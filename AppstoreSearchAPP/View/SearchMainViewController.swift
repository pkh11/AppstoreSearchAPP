//
//  SearchMainViewController.swift
//  AppstoreSearchAPP
//
//  Created by 박균호 on 2020/09/16.
//  Copyright © 2020 pkh. All rights reserved.
//

import UIKit

enum Type{
    case Searching
    case Results
}

class SearchMainViewController: UIViewController {
   
    @IBOutlet var keywordTableView: UITableView!
    let keywordViewModel = KeywordViewModel()
    let searchController = UISearchController(searchResultsController: nil)
    var type: Type = Type.Searching
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        keywordTableView.delegate = self
        keywordTableView.dataSource = self
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "App Store"
        searchController.searchBar.delegate = self
        
        self.navigationItem.searchController = searchController
        self.definesPresentationContext = true
    }
}
extension SearchMainViewController: UISearchResultsUpdating, UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchKeyword = searchController.searchBar.text else { return }
        if !searchKeyword.isEmpty {
            type = .Searching
            keywordViewModel.searchKeyword(searchKeyword)
        }
        self.keywordTableView.reloadData()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        // TODO: 검색 취소 시 셀타입 변경
        type = .Results
    }
}
extension SearchMainViewController: UITableViewDelegate, UITableViewDataSource {
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return keywordViewModel.searchKeywords.count
        } else {
            return keywordViewModel.recentKeywords.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if type == .Searching {
            let cell = tableView.dequeueReusableCell(withIdentifier: "keywordTableViewCell") as! KeywordTableViewCell
            
            if searchController.isActive && searchController.searchBar.text != "" {
                cell.keyword.text = keywordViewModel.searchKeywords[indexPath.row]
            } else {
                cell.keyword.text = keywordViewModel.recentKeywords[indexPath.row]
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultTableViewCell") as! SearchResultTableViewCell
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(indexPath.row)")
        // - TODO: api로 검색 시작
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: "keywordHeaderCell") as! KeywordHeaderCell
        header.headerTitle.text = "최근 검색어"
        return header
    }
}
