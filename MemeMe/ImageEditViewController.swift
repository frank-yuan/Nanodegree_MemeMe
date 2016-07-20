//
//  ViewController.swift
//  MemeMe
//
//  Created by Xuan Yuan (Frank) on 7/19/16.
//  Copyright © 2016 frank-yuan. All rights reserved.
//

import UIKit

class ImageEditViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    // MARK: Properties
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var actionButton: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomToolBar: UIToolbar!
    @IBOutlet weak var topToolbar: UIToolbar!
    
    var meme: Meme!
    var viewOriginY: CGFloat = 0
    
    // MARK: Constants
    let memeTextAttributes = [
    NSStrokeColorAttributeName : UIColor.blackColor(),
    NSForegroundColorAttributeName : UIColor.whiteColor(),
    NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
    NSStrokeWidthAttributeName : -3.0
    ]
    let textDel = ImageEditTextFieldDelegate()
    
    // MARK: UIViewController overrides
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        viewOriginY = self.view.frame.origin.y
        
        
        // Touch anywhere to stop textfield input
        let tapper = UITapGestureRecognizer(target: self, action: #selector(handleSingleTap(_:)))
        tapper.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tapper);
        
        topTextField.delegate = textDel
        topTextField.defaultTextAttributes = memeTextAttributes;
        topTextField.textAlignment = NSTextAlignment.Center
        bottomTextField.delegate = textDel
        bottomTextField.defaultTextAttributes = memeTextAttributes;
        bottomTextField.textAlignment = NSTextAlignment.Center
        
        
        configureUI(meme != nil)
        if (meme != nil)
        {
            imageView.image = meme.image;
            topTextField.text = meme.topText;
            bottomTextField.text = meme.bottomText;
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        // Subscribe to keyboard notifications to allow the view to raise when necessary
        self.subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotifications()
    }
    
    // MARK: ImagePicker Delegates
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.dismissViewControllerAnimated(true, completion: nil)
        imageView.image = image
        meme = nil
        configureUI(true)
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    // MARK: Actions
    @IBAction func onPickImage(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.delegate = self
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func onTakePhoto(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = UIImagePickerControllerSourceType.Camera
        imagePicker.delegate = self
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func onCancel(sender: AnyObject) {
        imageView.image = nil
        configureUI(false)
    }

    @IBAction func onShare(sender: AnyObject) {
        //generate a memed image
        let memedImg = generateMemedImage()
        
        saveMeme(memedImg)
        let vc = UIActivityViewController(activityItems: [memedImg], applicationActivities: nil)
//        vc.completionWithItemsHandler = onShareCompleted;
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
//    func onShareCompleted(str:String?, succeed:Bool, item:[AnyObject]?, error:NSError?)
//    {
//    }
    
    // MARK: Private methods
    func generateMemedImage() -> UIImage {
        topToolbar.hidden = true;
        bottomToolBar.hidden = true;
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawViewHierarchyInRect(self.view.frame,
                                     afterScreenUpdates: true)
        let memedImage : UIImage =
            UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        topToolbar.hidden = false;
        bottomToolBar.hidden = false;
        
        return memedImage
    }
    
    func configureUI(hasImage:Bool){
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        actionButton.enabled = hasImage
        cancelButton.enabled = hasImage
        
        topTextField.text = ""
        topTextField.hidden = !hasImage
        bottomTextField.text = ""
        bottomTextField.hidden = !hasImage
    }
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ImageEditViewController.keyboardWillShow(_:)), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(ImageEditViewController.keyboardWillHide(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        if (bottomTextField == ImageEditTextFieldDelegate.lastEditedTextfield) {
            self.view.frame.origin.y = viewOriginY - getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = viewOriginY
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo!
        let keyboardSize = userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    func saveMeme(memedImg:UIImage) {
        
        if (meme == nil) {
            meme = Meme(topText: topTextField.text!, bottomText: bottomTextField.text!, image: imageView.image!, memedImage: memedImg)
        }
        else {
            meme.topText = topTextField.text!
            meme.bottomText = bottomTextField.text!
            meme.memedImage = memedImg
        }

        (UIApplication.sharedApplication().delegate as!
            AppDelegate).memes.append(meme)
    }
    
    func handleSingleTap(sender:UITapGestureRecognizer){
        self.view.endEditing(true)
    }

}

