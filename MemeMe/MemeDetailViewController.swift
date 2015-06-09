//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Aldin Fajic on 6/6/15.
//  Copyright (c) 2015 Aldin Fajic. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    var meme: UIImage!
    var index: Int!
    var appDelegate: AppDelegate!

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.imageView.image = meme
        
        self.tabBarController?.tabBar.hidden = true
        
        let object = UIApplication.sharedApplication().delegate
        appDelegate = object as! AppDelegate

    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.hidden = false
    }
    
    @IBAction func deleteMeme(sender: UIBarButtonItem) {
        let controller = UIAlertController()
        controller.message = "This meme will be deleted from the collection"
        
        let deleteAction = UIAlertAction(title: "Delete Meme", style: UIAlertActionStyle.Destructive) { (UIAlertAction) -> Void in

           /* let object = UIApplication.sharedApplication().delegate
            let appDelegate = object as! AppDelegate

            appDelegate.memes.removeAtIndex(self.index) */
            self.appDelegate.memes.removeAtIndex(self.index)
            
            if (self.appDelegate.memes.isEmpty) {
                self.navigationController?.popToRootViewControllerAnimated(true)
            }
            else {
                if (self.index == 0) {
                    if (self.appDelegate.memes.count > 1) {
                        self.index = self.index + 1
                    }
                }
                else {
                    self.index = self.index - 1
                }
                self.imageView.image = self.appDelegate.memes[self.index].memedImage
                
            }
            

        }
        
        controller.addAction(deleteAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel) {
            action in self.navigationController?.popToRootViewControllerAnimated(true)
        }
        
        controller.addAction(cancelAction)
        self.presentViewController(controller, animated: true, completion: nil)
        
        
        
    }

    @IBAction func editMeme(sender: UIBarButtonItem) {
        let editMemeController = self.storyboard!.instantiateViewControllerWithIdentifier("EditMemeViewController") as! ViewController

        editMemeController.topText = self.appDelegate.memes[index].topText
        editMemeController.bottomText = self.appDelegate.memes[index].bottomText
        editMemeController.memeImg = self.appDelegate.memes[index].ogImage
        self.presentViewController(editMemeController, animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
