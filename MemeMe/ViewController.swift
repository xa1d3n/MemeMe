//
//  ViewController.swift
//  MemeMe
//
//  Created by Aldin Fajic on 6/3/15.
//  Copyright (c) 2015 Aldin Fajic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imagePickerView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func pickAnImage(sender: UIBarButtonItem) {
        // present image picker
        let imgPicker = UIImagePickerController()
        self.presentViewController(imgPicker, animated: true, completion: nil)
    }

}

