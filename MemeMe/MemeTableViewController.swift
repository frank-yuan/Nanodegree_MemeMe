//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by Xuan Yuan (Frank) on 7/21/16.
//  Copyright © 2016 frank-yuan. All rights reserved.
//

import UIKit

class MemeTableViewController: UITableViewController {

    // MARK: Constants
    let tableViewCellIdentifier = "memeTableCell"
    
    // MARK: ViewController overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        MemeUIHelper.setupNavigationItem(self, editable:true)
        MemeUIHelper.setNavigationBarEditMode(self, isEditing:false)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        MemeUIHelper.hideBarFor(self, navigationBar: false, tabBar: false)
        tableView.reloadData()
    }
    
    
    // MARK: TableView Delegates
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Meme.getMemeArray().count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(tableViewCellIdentifier)// as! MemeTableViewCell
        let meme = Meme.getMemeArray()[indexPath.row]
        //cell.memeImage.image = meme.memedImage
        cell?.imageView?.contentMode = UIViewContentMode.ScaleAspectFill
        cell?.imageView?.image = meme.memedImage
        cell?.textLabel!.text = meme.topText + "..." + meme.bottomText
        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        MemeUIHelper.presentMemeDetailViewController(self, meme: Meme.getMemeArray()[indexPath.row])
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100;
    }
    
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    //For deleting the Meme
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if (Meme.removeAt(indexPath.row)) {
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
}
