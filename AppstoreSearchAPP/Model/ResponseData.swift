//
//  ResponsData.swift
//  AppstoreSearchAPP
//
//  Created by 박균호 on 2020/09/18.
//  Copyright © 2020 pkh. All rights reserved.
//

import Foundation

struct ResponseData: Codable {
    var resultCount: Int?
    var results: [AppInfo]?
    
    enum CodingKeys: CodingKey {
        case resultCount
        case results
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        resultCount = try container.decode(Int.self, forKey: .resultCount)
        results = try container.decode([AppInfo].self, forKey: .results)
    }
}
