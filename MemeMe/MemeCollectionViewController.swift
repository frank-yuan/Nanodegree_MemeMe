//
//  MemeCollectionCollectionViewController.swift
//  MemeMe
//
//  Created by Xuan Yuan (Frank) on 7/22/16.
//  Copyright © 2016 frank-yuan. All rights reserved.
//

import UIKit


class MemeCollectionViewController: UICollectionViewController {
    // MARK: Constant
    private let reuseIdentifier = "MemeCollectionCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(presentImageEditViewController))
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.navigationBarHidden = false
        tabBarController?.tabBar.hidden = false
        collectionView?.reloadData()
    }


    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

//    override func 
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return Meme.getMemeArray().count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let memecell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath)
         as! MemeCollectionViewCell
        let meme = Meme.getMemeArray()[indexPath.row]
        memecell.imageView!.image = meme.memedImage
        memecell.textLabel!.text = meme.topText
        return memecell
    }

    // MARK: UICollectionViewDelegate

    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        presentImageEditViewControllerWithMeme(Meme.getMemeArray()[indexPath.row])
    }
    func presentImageEditViewController(){
        presentImageEditViewControllerWithMeme(nil)
    }
    
    func presentImageEditViewControllerWithMeme(meme:Meme? = nil) {
        let vc = storyboard!.instantiateViewControllerWithIdentifier("ImageEditViewController") as! ImageEditViewController
        vc.meme = meme
        navigationController?.pushViewController(vc, animated: true)
    }
}
