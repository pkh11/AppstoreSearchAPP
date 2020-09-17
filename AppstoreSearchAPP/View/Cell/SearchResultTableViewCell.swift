//
//  SearchResultTableViewCell.swift
//  AppstoreSearchAPP
//
//  Created by 박균호 on 2020/09/17.
//  Copyright © 2020 pkh. All rights reserved.
//

import UIKit


class SearchResultTableViewCell: UITableViewCell {
    
    @IBOutlet weak var appIcon: UIImageView!
    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var appCategory: UILabel!
    @IBOutlet weak var appStar: UILabel!
    @IBOutlet weak var installButton: UIButton!
    @IBOutlet weak var preview1: UIImageView!
    @IBOutlet weak var preview2: UIImageView!
    @IBOutlet weak var preview3: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
