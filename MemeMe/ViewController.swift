//
//  ViewController.swift
//  MemeMe
//
//  Created by Aldin Fajic on 6/3/15.
//  Copyright (c) 2015 Aldin Fajic. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var imagePickerView: UIImageView!
    
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    var controller: UIActivityViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        topTextField.delegate = self
        bottomTextField.delegate = self
        self.shareButton.enabled = false
        
        
        let memeTextAttributes = [
            NSStrokeColorAttributeName : UIColor.whiteColor(),
            NSForegroundColorAttributeName : UIColor.blackColor(),
            NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSStrokeWidthAttributeName : 3.0
        ]

    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        // disable camera button if no camera is unavailable
        super.viewWillAppear(animated)
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable( UIImagePickerControllerSourceType.Camera)
        
        self.subscribeToKeyboardNotifications()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.unsubscribeFromKeyboardNotifications()
    }
    
    
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
         NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        self.view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    
    func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y += getKeyboardHeight(notification)
    }
    
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }


    @IBAction func pickAnImageFromAlbum(sender: UIBarButtonItem) {
        // setup image picker
        let imgPicker = UIImagePickerController()
        //set delegate
        imgPicker.delegate = self
        // set image source
        imgPicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        // display image picker
        self.presentViewController(imgPicker, animated: true, completion: nil)
    }
    
    @IBAction func pickAnImageFromCamera(sender: UIBarButtonItem) {
        // setup image picker
        let imgPicker = UIImagePickerController()
        //set delegate
        imgPicker.delegate = self
        // set image source
        imgPicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        // display image picker
        self.presentViewController(imgPicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        self.dismissViewControllerAnimated(true, completion: nil)
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.imagePickerView.image = image
            self.shareButton.enabled = true
        }
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.view.resignFirstResponder()
        self.view.endEditing(true)
    }
    
    func save() {
        var meme = Meme(topText: topTextField.text, bottomText: bottomTextField.text, ogImage: imagePickerView.image!, memedImage: generateMemedImage())
        controller.dismissViewControllerAnimated(true, completion: nil)
        
        // add to the memes array in AppDelegate.swift
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
    
    func generateMemedImage() -> UIImage {
        
        // Hide toolbar and navbar
        self.navigationController?.navigationBar.hidden = true
        self.navigationController?.toolbar.hidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //  Show toolbar and navbar
        self.navigationController?.navigationBar.hidden = false
        self.navigationController?.toolbar.hidden = false
        
        return memedImage
    }
    
    @IBAction func share(sender: UIBarButtonItem) {
        // pass image to share
        controller = UIActivityViewController(activityItems: [generateMemedImage()], applicationActivities: nil)
        // present the controller
        
        self.presentViewController(controller, animated: true, completion: nil)
        controller.completionWithItemsHandler = { activity, success, items, error in
            self.save()
        }
    }
    
    @IBAction func cancel(sender: UIBarButtonItem) {
        
    }

}

