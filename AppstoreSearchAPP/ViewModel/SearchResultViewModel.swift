//
//  SearchResultViewModel.swift
//  AppstoreSearchAPP
//
//  Created by 박균호 on 2020/09/17.
//  Copyright © 2020 pkh. All rights reserved.
//

import Foundation

class SearchResultViewModel {
    var appInfo = [AppInfo]()
    let network = AppDelegate.api
    
    func getData(_ callURL: String ,_ keyword: String, completion: @escaping ([AppInfo]) -> Void) {
        network.requestPost(url: callURL, method: Method.POST, param: ["term":keyword, "entity":"software"]) { response in
            if let data = response {
                if let jsonDatas = try? JSONDecoder().decode(ResponseData.self, from: data) {
                    if let result = jsonDatas.results {
                        self.appInfo = result
                        completion(self.appInfo)
                    }
                }
            }
        }
    }
}
