//
//  AppIconCell.swift
//  AppstoreSearchAPP
//
//  Created by 박균호 on 2020/09/20.
//  Copyright © 2020 pkh. All rights reserved.
//

import UIKit

class AppIconCell: UITableViewCell {
    
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var appTitle: UILabel!
    @IBOutlet weak var appSubtitle: UILabel!
    @IBOutlet weak var excuteButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var grade: UILabel!
    @IBOutlet weak var subGrade: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBOutlet weak var subCategory: UILabel!
    @IBOutlet weak var age: UILabel!
    @IBOutlet weak var subAge: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

class NewFeatureCell: UITableViewCell {
    
    @IBOutlet weak var versionHistoryButton: UILabel!
    @IBOutlet weak var versionInfo: UILabel!
    @IBOutlet weak var historyDate: UILabel!
    @IBOutlet weak var newFeatureContents: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

class PreviewCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var imageURLs = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()

        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func configure(with images: [String]) {
        self.imageURLs = images
        self.collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageURLs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "previewCollectionViewCell", for: indexPath) as! PreviewCollectionViewCell
        cell.previewImage.downloaded(from: imageURLs[indexPath.row] )
        return cell
    }
}

class DescriptionCell: UITableViewCell {
    
    @IBOutlet weak var descriptionView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}

class PreviewCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var previewImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure(with images: String) {
        previewImage.downloaded(from: images)
    }
}
