//
//  KeywordViewModel.swift
//  AppstoreSearchAPP
//
//  Created by 박균호 on 2020/09/17.
//  Copyright © 2020 pkh. All rights reserved.
//

import Foundation

class KeywordViewModel {
    
    var searchKeywords = [String]()
    var recentKeywords = [String]()
    
    func searchKeyword(_ searchKeyword: String){
        searchKeywords.append(searchKeyword)
    }
    func filteredKeyword(_ searhKeyword: String) {
        searchKeywords = recentKeywords.filter({ (keyword: String) -> Bool in return keyword.lowercased().contains(searhKeyword.lowercased())})
    }
    func getRecentKeyword(){
        if let arrays = AppDelegate.userDefaults.object(forKey: "keyWordList") as? [String] {
            recentKeywords = arrays
        }
    }
}
