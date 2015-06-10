//
//  ViewController.swift
//  MemeMe
//
//  Created by Aldin Fajic on 6/3/15.
//  Copyright (c) 2015 Aldin Fajic. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet weak var toolBar: UIToolbar!
    @IBOutlet weak var imagePickerView: UIImageView!
    @IBOutlet weak var navBar: UINavigationBar!
    
    @IBOutlet weak var bottomTextField: UITextField!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    var topText: String!
    var bottomText: String!
    var memeImg: UIImage!
    
    var controller: UIActivityViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // set delegates
        topTextField.delegate = self
        bottomTextField.delegate = self
        
        // disable the share button
        self.shareButton.enabled = false
        
        // set placeholder text color
        self.topTextField.attributedPlaceholder = NSAttributedString(string:"TOP",
            attributes:[NSForegroundColorAttributeName: UIColor.whiteColor()])
        
        // set placeholder text color
        self.bottomTextField.attributedPlaceholder = NSAttributedString(string: "BOTTOM", attributes: [NSForegroundColorAttributeName: UIColor.whiteColor()])

    }
    
    
    
    override func viewWillAppear(animated: Bool) {
        // disable camera button if no camera is unavailable
        super.viewWillAppear(animated)
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable( UIImagePickerControllerSourceType.Camera)
        
        self.subscribeToKeyboardNotifications()
        
        // set data when editing
        if (topText != nil) {
            topTextField.text = topText
        }
        
        if (bottomText != nil) {
            bottomTextField.text = bottomText
        }
        
        if (memeImg != nil) {
            imagePickerView.image = memeImg
            self.shareButton.enabled = true
        }
        
    }
    
    
    // hide the status bar
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        // unsubscribe from keyboard
        self.unsubscribeFromKeyboardNotifications()
    }
    
    
    // handle keyboard typing
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    // unsubscribe from keyboard events
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
         NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    // move view up when keyboard is shown
    func keyboardWillShow(notification: NSNotification) {
        view.frame.origin.y -= getKeyboardHeight(notification)
    }
    
    
    // move view down when keyboard is dismissed
    func keyboardWillHide(notification: NSNotification) {
        view.frame.origin.y += getKeyboardHeight(notification)
    }
    
    // set keyboard height
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }


    // handle image picker button
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
    
    // handle camera button
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
    
    // handle did cancel image selection
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // handle selection of image
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        // dismiss the view
        self.dismissViewControllerAnimated(true, completion: nil)
        // set image
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePickerView.image = image
            shareButton.enabled = true
            
        }
    }
    
    // hide keyboard on return
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    // hide keyboar on tap
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        view.resignFirstResponder()
        view.endEditing(true)
    }
    
    // save meme iformation
    func save() {
        var meme = Meme(topText: topTextField.text, bottomText: bottomTextField.text, ogImage: imagePickerView.image!, memedImage: generateMemedImage())
        controller.dismissViewControllerAnimated(true, completion: nil)
        
        // add to the memes array in AppDelegate.swift
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
    
    // generate image from view
    func generateMemedImage() -> UIImage {
        
        // Hide toolbar and navbar
        toolBar.hidden = true
        navBar.hidden = true
        
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawViewHierarchyInRect(self.view.frame,
            afterScreenUpdates: true)
        let memedImage : UIImage =
        UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //  Show toolbar and navbar
        toolBar.hidden = false
        navBar.hidden = false
        
        return memedImage
    }
    
    // hadle share button
    @IBAction func share(sender: UIBarButtonItem) {
        // pass image to share
        controller = UIActivityViewController(activityItems: [generateMemedImage()], applicationActivities: nil)
        // present the controller
        
        self.presentViewController(controller, animated: true, completion: nil)
        controller.completionWithItemsHandler = { activity, success, items, error in
            self.save()
        }
    }

}

