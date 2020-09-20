//
//  SearchMainViewController.swift
//  AppstoreSearchAPP
//
//  Created by 박균호 on 2020/09/16.
//  Copyright © 2020 pkh. All rights reserved.
//

import UIKit

enum Type{
    case Main
    case Searching
}

class SearchMainViewController: UIViewController, UISearchControllerDelegate {
    
    @IBOutlet var keywordTableView: UITableView!
    
    let keywordViewModel = KeywordViewModel()
    var searchResultViewController: SearchResultViewController!
    var searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        keywordViewModel.getRecentKeyword()
        
        keywordTableView.delegate = self
        keywordTableView.dataSource = self
        
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "App Store"
        searchController.searchBar.delegate = self
        
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController = searchController
        definesPresentationContext = false
    }

    func moveToResultViewController(_ keyword: String){
        searchResultViewController = self.storyboard?.instantiateViewController(withIdentifier: "searchResultViewController") as? SearchResultViewController
        searchResultViewController.keyword = keyword
        self.addChild(searchResultViewController)
        self.view.frame = searchResultViewController.view.frame
        self.view.addSubview(searchResultViewController.view)
        searchResultViewController.didMove(toParent: self)
    }
}
extension SearchMainViewController: UISearchResultsUpdating, UISearchBarDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let searchKeyword = searchController.searchBar.text else { return }
        if isFiltering() {
            keywordViewModel.filteredKeyword(searchKeyword)
        }
        DispatchQueue.main.async {
            self.keywordTableView.reloadData()
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        if let resultViewController = searchResultViewController {
            resultViewController.view.removeFromSuperview()
            resultViewController.removeFromParent()
        }
        DispatchQueue.main.async {
            self.keywordTableView.reloadData()
        }
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                searchBar.resignFirstResponder()
            }
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !searchBarIsEmpty() {
            if let keyword = searchBar.text {
                var arrays = keywordViewModel.recentKeywords
                if arrays.contains(keyword) {
                    if let index = arrays.firstIndex(of: keyword) {
                        arrays.remove(at: index)
                    }
                }
                arrays.insert(keyword, at: 0)
                AppDelegate.userDefaults.set(arrays, forKey: "keyWordList")
                moveToResultViewController(keyword)
            }
        }
    }
    
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
}
extension SearchMainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering() {
            return keywordViewModel.searchKeywords.count
        }
        return keywordViewModel.recentKeywords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "keywordCell") as! SearchKeywordCell
        if isFiltering() {
            cell.keyword.textColor = .black
            cell.keyword.text = keywordViewModel.searchKeywords[indexPath.row]
            cell.searchIconImage.isHidden = false
        } else {
            cell.keyword.textColor = .systemBlue
            cell.keyword.text = keywordViewModel.recentKeywords[indexPath.row]
            cell.searchIconImage.isHidden = true
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var keyword = ""
        if isFiltering() {
            keyword = keywordViewModel.searchKeywords[indexPath.row]
        } else {
            keyword = keywordViewModel.recentKeywords[indexPath.row]
        }
        searchController.searchBar.text = keyword
        searchController.isActive = true
        
        moveToResultViewController(keyword)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: "keywordHeaderCell") as! KeywordHeaderCell
        header.headerTitle.text = "최근 검색어"
        header.isHidden = false
        return header
    }
    
}
