//
//  CellGenreHot.swift
//  MangaJar
//
//  Created by Nguyen Tien Quan on 24/03/2023.
//

import UIKit

class CellGenreHot: UICollectionViewCell {
    @IBOutlet weak var titleGenreHot: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleGenreHot.layer.cornerRadius = 10
    }
    
}
