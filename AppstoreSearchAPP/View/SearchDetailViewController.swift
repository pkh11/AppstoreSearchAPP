//
//  SearchDetailViewController.swift
//  AppstoreSearchAPP
//
//  Created by 박균호 on 2020/09/20.
//  Copyright © 2020 pkh. All rights reserved.
//

import UIKit

class SearchDetailViewController: UIViewController{
    
    @IBOutlet weak var searchDetailTableView: UITableView!
    var appInfo = AppInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        searchDetailTableView.delegate = self
        searchDetailTableView.dataSource = self
    }
    @IBAction func installApp(_ sender: Any) {
        let alert = UIAlertController(title: "알림", message: "준비중입니다.", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "확인", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: nil))

        self.present(alert, animated: true)
    }
}
extension SearchDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        if section == 0 {
            let appIconCell = tableView.dequeueReusableCell(withIdentifier: "appIconCell") as! AppIconCell
            appIconCell.iconImage.downloaded(from: appInfo.artworkUrl100!)
            appIconCell.appTitle.text = appInfo.trackName
            appIconCell.appSubtitle.text = appInfo.sellerName
            
            appIconCell.grade.text = String(format: "%.1f", appInfo.averageUserRating!) + "★★★☆☆"
            appIconCell.subGrade.text = "3만개의 평가"
            
            appIconCell.category.text = "#3"
            appIconCell.subCategory.text = appInfo.gereNameInKOR
            
            appIconCell.age.text = appInfo.contentAdvisoryRating
            appIconCell.subAge.text = "연령"
            return appIconCell
        }
        if section == 1 {
            let newFeatureCell = tableView.dequeueReusableCell(withIdentifier: "newFeatureCell") as! NewFeatureCell
            newFeatureCell.versionInfo.text = "버전 \(String(describing: appInfo.version!))"
            newFeatureCell.historyDate.text = "1주전"
            newFeatureCell.newFeatureContents.text = appInfo.releaseNotes
            
            return newFeatureCell
        }
        if section == 2 {
            let previewCell = tableView.dequeueReusableCell(withIdentifier: "previewCell") as! PreviewCell
            previewCell.configure(with: appInfo.screenshotUrls!)
            return previewCell
        }
        if section == 3 {
            let descriptionCell = tableView.dequeueReusableCell(withIdentifier: "descriptionCell") as! DescriptionCell
            descriptionCell.descriptionView.text = appInfo.description
            return descriptionCell
        }
        return tableView.cellForRow(at: indexPath)!
    }
    func numberOfSections(in tableView: UITableView) -> Int {
       return 4
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 2 {
            return 360
        } else {
            return tableView.estimatedRowHeight
        }
    }
    
}


