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
}
