//
//  MemeHelper.swift
//  MemeMe
//
//  Created by Xuan Yuan (Frank) on 7/24/16.
//  Copyright © 2016 frank-yuan. All rights reserved.
//

import UIKit

class MemeUIHelper {
    
    static func setupNavigationItem(viewController:UIViewController, editable editable:Bool) {
        viewController.navigationItem.title = "Sent Memes"
        viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.Plain, target: viewController, action: "presentMemeEditViewController")
        if (editable) {
            setNavigationBarEditMode(viewController, isEditing:false)
        }
    }
    
    static func hideBarFor(vc:UIViewController, navigationBar hideNaviBar:Bool, tabBar hideTabBar:Bool){
        vc.navigationController?.navigationBarHidden = hideNaviBar
        vc.tabBarController?.tabBar.hidden = hideTabBar
    }
    
    static func pushMemeEditViewController(currentViewController:UIViewController, meme:Meme? = nil) {
        let vc = currentViewController.storyboard!.instantiateViewControllerWithIdentifier("MemeEditViewController") as! MemeEditViewController
        vc.meme = meme
        currentViewController.presentViewController(vc, animated: true, completion: nil)
    }
    
    static func presentMemeDetailViewController(currentViewController:UIViewController, meme:Meme? = nil) {
        let vc = currentViewController.storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        vc.meme = meme
        currentViewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    static func setNavigationBarEditMode(viewController:UIViewController, isEditing editing:Bool) {
        if (editing) {
            viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: viewController, action: "endEditMode")
        }
        else {
            viewController.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.Plain, target: viewController, action: "enterEditMode")
        }
    }
    
}

extension MemeTableViewController {
    @objc func presentMemeEditViewController(){
        MemeUIHelper.pushMemeEditViewController(self)
    }
    
    @objc private func enterEditMode() {
        editing = true
        MemeUIHelper.setNavigationBarEditMode(self, isEditing:true)
    }
    
    @objc private func endEditMode() {
        editing = false
        MemeUIHelper.setNavigationBarEditMode(self, isEditing:false)
    }
}
// Any suggestion to eliminate these repetitive methods apart from deriving them from one base class?
extension MemeCollectionViewController {
    @objc func presentMemeEditViewController(){
        MemeUIHelper.pushMemeEditViewController(self)
    }
    
    @objc private func enterEditMode() {
        editing = true
        MemeUIHelper.setNavigationBarEditMode(self, isEditing:true)
    }
    
    @objc private func endEditMode() {
        editing = false
        MemeUIHelper.setNavigationBarEditMode(self, isEditing:false)
    }
}

