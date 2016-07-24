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
    private let cellSpacing:CGFloat = 0.5
    // MARK: IBOutlet
    @IBOutlet weak var collectionViewFlowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        MemeUIHelper.setupNavigationItem(self, editable:false)
    }
    
    override func viewWillAppear(animated: Bool) {
        MemeUIHelper.hideBarFor(self, navigationBar: false, tabBar: false)
        collectionView?.reloadData()
        collectionViewFlowLayout.minimumInteritemSpacing = cellSpacing
        collectionViewFlowLayout.minimumLineSpacing = cellSpacing
        resizeCollectionLayout()
    }


    override func didRotateFromInterfaceOrientation(fromInterfaceOrientation: UIInterfaceOrientation) {
        resizeCollectionLayout()
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
        MemeUIHelper.presentMemeDetailViewController(self, meme: Meme.getMemeArray()[indexPath.row])
    }

    
    // MARK: Private functions
    
    func resizeCollectionLayout() {
        let count:CGFloat = view.frame.width > view.frame.height ? 5.0 : 3.0
        let size:CGFloat = (view.frame.width - (count + 1) * cellSpacing) / count
        collectionViewFlowLayout.itemSize = CGSize(width: size, height: size)
    }
    
}
