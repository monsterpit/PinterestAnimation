//
//  CollectionViewController.swift
//  PinterestAnimation
//
//  Created by MyGlamm on 6/1/20.
//  Copyright © 2020 MyGlamm. All rights reserved.
//

import UIKit

private let reuseIdentifier = "NTHorizontalPageViewCell"

class CollectionViewController: UICollectionViewController {

    var imageNameList : [String] = []
    var pullOffset = CGPoint.zero
    var indexPath: IndexPath = IndexPath(item: 0, section: 0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.setCollectionViewLayout(pageViewControllerLayout(), animated: false)
        // Register cell classes
        collectionView.register(NTHorizontalPageViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        collectionView.isPagingEnabled = true
        collectionView.setToIndexPath(indexPath)

        collectionView.performBatchUpdates({collectionView.reloadData()}, completion: { [weak self] finished in
            guard let `self` = self else {return}
            if finished {
                self.collectionView.scrollToItem(at: self.indexPath,at:.centeredHorizontally, animated: false)
            }});
    }
    
    
    func pageViewControllerLayout() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        let itemSize  = self.navigationController!.isNavigationBarHidden ?
        CGSize(width: screenWidth, height: screenHeight+20) : CGSize(width: screenWidth, height: screenHeight-navigationHeaderAndStatusbarHeight)
        flowLayout.itemSize = itemSize
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        return flowLayout
    }
    

    // MARK: UICollectionViewDataSource

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  imageNameList.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let collectionCell: NTHorizontalPageViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! NTHorizontalPageViewCell
        collectionCell.imageName = self.imageNameList[indexPath.row] as String
        collectionCell.tappedAction = {}
        collectionCell.pullAction = { offset in
            self.pullOffset = offset
            self.navigationController!.popViewController(animated: true)
        }
        collectionCell.setNeedsLayout()
        return collectionCell
    }
}

extension CollectionViewController: NTTransitionProtocol{
    func transitionCollectionView() -> UICollectionView! {
        collectionView
    }
}

extension CollectionViewController: NTHorizontalPageViewControllerProtocol{
    func pageViewCellScrollViewContentOffset() -> CGPoint {
        return self.pullOffset
    }
}
