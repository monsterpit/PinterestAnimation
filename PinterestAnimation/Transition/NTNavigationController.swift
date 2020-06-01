//
//  NTNavigationController.swift
//  PinterestAnimation
//
//  Created by MyGlamm on 6/1/20.
//  Copyright © 2020 MyGlamm. All rights reserved.
//

import UIKit
class NTNavigationController : UINavigationController{
    override func popViewController(animated: Bool) -> UIViewController
    {
        //viewWillAppearWithPageIndex
        let childrenCount = self.viewControllers.count
        let toViewController = self.viewControllers[childrenCount-2] as! NTWaterFallViewControllerProtocol
        let toView = toViewController.transitionCollectionView()
        let popedViewController = self.viewControllers[childrenCount-1] as! UICollectionViewController
        let popView  = popedViewController.collectionView!;
        let indexPath = popView.fromPageIndexPath()
        toViewController.viewWillAppearWithPageIndex(indexPath.row)
        toView?.setToIndexPath(indexPath)
        return super.popViewController(animated: animated)!
    }
    
//    override func pushViewController(viewController: UIViewController!, animated: Bool) {
//        let childrenCount = self.viewControllers.count
//        let toView = viewController.view
//        let currentView = self.viewControllers[childrenCount-1].view
////        if toView is UICollectionView && currentView is UICollectionView{
////            let currentIndexPath = (currentView as UICollectionView).currentIndexPath()
////            (toView as UICollectionView).setCurrentIndexPath(currentIndexPath)
////        }
//        super.pushViewController(viewController, animated: animated)
//    }
}

class NavigationControllerDelegate: NSObject, UINavigationControllerDelegate{
    internal func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning?{
        
        let fromVCConfromA = (fromVC as? NTTransitionProtocol)
        let fromVCConfromB = (fromVC as? NTWaterFallViewControllerProtocol)
        let fromVCConfromC = (fromVC as? NTHorizontalPageViewControllerProtocol)
        
        let toVCConfromA = (toVC as? NTTransitionProtocol)
        let toVCConfromB = (toVC as? NTWaterFallViewControllerProtocol)
        let toVCConfromC = (toVC as? NTHorizontalPageViewControllerProtocol)
        if((fromVCConfromA != nil)&&(toVCConfromA != nil)&&(
            (fromVCConfromB != nil && toVCConfromC != nil)||(fromVCConfromC != nil && toVCConfromB != nil))){
            let transition = NTTransition()
            transition.presenting = operation == .pop
            return  transition
        }else{
            return nil
        }
        
    }
}
