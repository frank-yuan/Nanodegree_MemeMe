//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Xuan Yuan (Frank) on 7/23/16.
//  Copyright © 2016 frank-yuan. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    var meme: Meme!
    @IBOutlet weak var imageView:UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (meme != nil)
        {
            imageView.image = meme.memedImage;
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(presentMemeEditViewController))
        MemeUIHelper.hideBarFor(self, navigationBar: false, tabBar: true)
    }
    
    func presentMemeEditViewController() {
        MemeUIHelper.pushMemeEditViewController(self, meme: meme)
    }
}
