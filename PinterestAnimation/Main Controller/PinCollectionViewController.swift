//
//  PinCollectionViewController.swift
//  PinterestAnimation
//
//  Created by MyGlamm on 6/1/20.
//  Copyright © 2020 MyGlamm. All rights reserved.
//

import UIKit

private let reuseIdentifier = "CustomCollectionViewCell"

class PinCollectionViewController: UICollectionViewController {

    var imageNameList : [String] = []
    let delegateHolder = NavigationControllerDelegate()
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
        
        self.navigationController!.delegate = delegateHolder
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        let pageViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CollectionViewController") as! CollectionViewController
        pageViewController.indexPath = indexPath
        pageViewController.imageNameList = imageNameList
        collectionView.setToIndexPath(indexPath)
        navigationController!.pushViewController(pageViewController, animated: true)
    }

}

extension PinCollectionViewController: CHTCollectionViewDelegateWaterfallLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let image:UIImage! = UIImage(named: self.imageNameList[indexPath.row] as String)
        let imageHeight = image.size.height * gridWidth/image.size.width
        return CGSize(width: gridWidth, height: imageHeight)
    }

}


extension PinCollectionViewController: NTTransitionProtocol{
    //Animate the collectionView
    func transitionCollectionView() -> UICollectionView! {
        collectionView
    }
}

extension PinCollectionViewController: NTWaterFallViewControllerProtocol{
    //Animate the current VC to collection
    func viewWillAppearWithPageIndex(_ pageIndex: NSInteger) {
        var position: UICollectionView.ScrollPosition =
            UICollectionView.ScrollPosition.centeredHorizontally.intersection(.centeredVertically)
        let image: UIImage! = UIImage(named: self.imageNameList[pageIndex] as String)
        let imageHeight = image.size.height*gridWidth/image.size.width
        if imageHeight > 400 {//whatever you like, it's the max value for height of image
           position = .top
        }
        let currentIndexPath = IndexPath(row: pageIndex, section: 0)
        collectionView.setToIndexPath(currentIndexPath)
        
        if pageIndex < 2{
            collectionView.setContentOffset(CGPoint.zero, animated: false)
        }
        else{
            collectionView.scrollToItem(at: currentIndexPath, at: position, animated: false)
        }
    }
}
