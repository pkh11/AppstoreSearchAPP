//
//  SearchResultViewController.swift
//  AppstoreSearchAPP
//
//  Created by 박균호 on 2020/09/18.
//  Copyright © 2020 pkh. All rights reserved.
//

import UIKit

class SearchResultViewController: UIViewController {
    
    var keyword: String = ""
    var searchResultViewModel = SearchResultViewModel()
    var callURL = API.SEARCH_API
    var datas = [AppInfo]()
    
    @IBOutlet weak var searchResultTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
        searchResultTableView.keyboardDismissMode = .onDrag
        
        searchResultViewModel.getData(callURL, keyword) { appInfo in
            self.datas = appInfo
            DispatchQueue.main.async {
                self.searchResultTableView.reloadData()
                self.scrollToTop()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        searchResultViewModel.getData(callURL, keyword) { appInfo in
            self.datas = appInfo
            DispatchQueue.main.async {
                self.searchResultTableView.reloadData()
                self.scrollToTop()
            }
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        self.view.endEditing(true)
    }
}
extension SearchResultViewController: UITableViewDelegate, UITableViewDataSource {
    private func scrollToTop() {
        let topRow = IndexPath(row: 0, section: 0)
        searchResultTableView.scrollToRow(at: topRow, at: .top, animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "searchResultTableViewCell") as! SearchResultTableViewCell
        let appInfo = datas[indexPath.row]
        
        DispatchQueue.main.async {
            cell.appName.text = appInfo.trackName
            cell.appIcon.downloaded(from: appInfo.artworkUrl100!)
            
            let imageCount = appInfo.screenshotUrls!.count
            
            if imageCount >= 3 {
                cell.preview1.downloaded(from: appInfo.screenshotUrls?[0] ?? "")
                cell.preview2.downloaded(from: appInfo.screenshotUrls?[1] ?? "")
                cell.preview3.downloaded(from: appInfo.screenshotUrls?[2] ?? "")
            } else if imageCount == 2 {
                cell.preview1.downloaded(from: appInfo.screenshotUrls?[0] ?? "")
                cell.preview2.downloaded(from: appInfo.screenshotUrls?[1] ?? "")
                cell.preview3.isHidden = true
            } else if imageCount == 1 {
                cell.preview1.downloaded(from: appInfo.screenshotUrls?[0] ?? "")
                cell.preview2.isHidden = true
                cell.preview3.isHidden = true
            }
            
            cell.appCategory.text = appInfo.gereNameInKOR
            cell.appStar.text = "★★★☆☆"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let searchDetailViewController = self.storyboard?.instantiateViewController(identifier: "searchDetailViewContrller") as! SearchDetailViewController
        searchDetailViewController.appInfo = datas[indexPath.row]
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.pushViewController(searchDetailViewController, animated: true)
    }
}
