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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func pickAnImage(sender: UIBarButtonItem) {
        // setup image picker
        let imgPicker = UIImagePickerController()
        //set delegate
        imgPicker.delegate = self
        // display image picker
        self.presentViewController(imgPicker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}

