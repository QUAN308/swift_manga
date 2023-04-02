//
//  CellHistory.swift
//  MangaJar
//
//  Created by Nguyen Tien Quan on 23/03/2023.
//

import UIKit

class CellHistory: UICollectionViewCell {
    @IBOutlet weak var imageHistory: UIImageView!
    @IBOutlet weak var titleHistory: UILabel!
    @IBOutlet weak var chapterHistory: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        imageHistory.layer.cornerRadius = 5
    }

}
