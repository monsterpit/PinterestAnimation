//
//  CustomCollectionViewCell.swift
//  PinterestAnimation
//
//  Created by MyGlamm on 6/1/20.
//  Copyright © 2020 MyGlamm. All rights reserved.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {

    var imageName : String?
    
    @IBOutlet weak var pinImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func layoutSubviews() {
        pinImageView.image = UIImage(named: imageName!)
    }
}
