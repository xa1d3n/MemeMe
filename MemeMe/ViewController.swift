//
//  ViewController.swift
//  MemeMe
//
//  Created by Aldin Fajic on 6/3/15.
//  Copyright (c) 2015 Aldin Fajic. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imagePickerView: UIImageView!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(animated: Bool) {
        // disable camera button if no camera is unavailable
        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable( UIImagePickerControllerSourceType.Camera)
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
        }
    }

}

