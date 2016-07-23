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
    let tableViewSegueIdentifier = "pushMemeDisplay"
    
    // MARK: ViewController overrides
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(presentImageEditViewController))
    }
    override func viewWillAppear(animated: Bool) {
        navigationController?.navigationBarHidden = false
        tabBarController?.tabBar.hidden = false
        tableView.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == tableViewSegueIdentifier)
        {
            if let ip = tableView.indexPathForSelectedRow {
                if let vc = segue.destinationViewController as? MemeDisplayViewController {
                    vc.meme = Meme.getMemeArray()[ip.row]
                }
            }
        }
    }
    
    // MARK: TableView Delegates
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Meme.getMemeArray().count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(tableViewCellIdentifier)
        let meme = Meme.getMemeArray()[indexPath.row]
        cell?.imageView?.image = meme.memedImage
        cell?.textLabel!.text = meme.topText + "..." + meme.bottomText
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        presentMemeDisplayViewController()
    }
    
    // MARK: - Private functions
    func presentImageEditViewController(){
        ImageEditViewController.pushImageEditViewController(self)
    }
    
    func presentMemeDisplayViewController() {
        performSegueWithIdentifier(tableViewSegueIdentifier, sender: self)
    }
}
