//
//  Newtorking.swift
//  AppstoreSearchAPP
//
//  Created by 박균호 on 2020/09/18.
//  Copyright © 2020 pkh. All rights reserved.
//

import Foundation

enum Method: String {
    case POST = "POST"
    case GET = "GET"
}

class API {
    static let sharedInstance = API()
    static let HOST = "https://itunes.apple.com"
    static var SEARCH_API: String {
        return "\(HOST)" + "/search"
    }
}

class Networking {
    private let session = URLSession.shared
    
    func requestPost(url: String, method: Method, param: [String:Any], responseCallback: @escaping (Data?) -> Void) {
        guard let url = URL(string: url) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = "term=\(String(describing: param["term"] as? String ?? ""))&entity=software".data(using: .utf8)
        
        session.dataTask(with: request) { (data, response, error) in
            if let reponseData = response as? HTTPURLResponse {
                if reponseData.statusCode == 200 {
                    responseCallback(data)
                } else {
                    print("Status Code is not 200")
                }
            }
        }.resume()
    }
}
