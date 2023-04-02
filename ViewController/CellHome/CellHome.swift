//
//  CellHome.swift
//  MangaJar
//
//  Created by Nguyen Tien Quan on 22/03/2023.
//

import UIKit

class CellHome: UICollectionViewCell {
    @IBOutlet weak var imageCellHome: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        imageCellHome.layer.cornerRadius = 5
    }

}
