//
//  PinCollectionViewController.swift
//  PinterestAnimation
//
//  Created by MyGlamm on 6/1/20.
//  Copyright © 2020 MyGlamm. All rights reserved.
//

import UIKit

private let reuseIdentifier = "CustomCollectionViewCell"

let screenBounds = UIScreen.main.bounds
let screenSize   = screenBounds.size
let screenWidth  = screenSize.width
let screenHeight = screenSize.height
let gridWidth : CGFloat = (screenSize.width/2)-5.0

class PinCollectionViewController: UICollectionViewController {

    var imageNameList : [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()

        // Register cell classes
        self.collectionView!.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        
        self.collectionView.setCollectionViewLayout(CHTCollectionViewWaterfallLayout(), animated: false)

        var index = 0
        while index < 14{
            
            let imageName = String(format: "%d.jpg", index)
            imageNameList.append(imageName)
            index += 1
        }
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return imageNameList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell: CustomCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! CustomCollectionViewCell
        collectionCell.imageName = self.imageNameList[indexPath.row] as String
        collectionCell.setNeedsLayout()
        return collectionCell
    }
}

extension PinCollectionViewController: CHTCollectionViewDelegateWaterfallLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let image:UIImage! = UIImage(named: self.imageNameList[indexPath.row] as String)
        let imageHeight = image.size.height * gridWidth/image.size.width
        return CGSize(width: gridWidth, height: imageHeight)
    }

}
