//
//  CellForNewbie.swift
//  MangaJar
//
//  Created by Nguyen Tien Quan on 24/03/2023.
//

import UIKit

class CellForNewbie: UICollectionViewCell {
    @IBOutlet weak var imageNewbie: UIImageView!
    @IBOutlet weak var titleNewbie: UILabel!
    @IBOutlet weak var descriptNewbie: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        imageNewbie.layer.cornerRadius = 5
    }

}
