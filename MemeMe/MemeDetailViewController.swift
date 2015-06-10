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
        imageView.image = meme
        
        // hide tab bar
        tabBarController?.tabBar.hidden = true
        
        // get memes
        let object = UIApplication.sharedApplication().delegate
        appDelegate = object as! AppDelegate

    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        // show tab bar
        tabBarController?.tabBar.hidden = false
    }
    
    // handle delete meme button
    @IBAction func deleteMeme(sender: UIBarButtonItem) {
        // set alert properties
        let controller = UIAlertController()
        controller.message = "This meme will be deleted from the collection"
        
        // handle delete button
        let deleteAction = UIAlertAction(title: "Delete Meme", style: UIAlertActionStyle.Destructive) { (UIAlertAction) -> Void in

            // remove the meme
            self.appDelegate.memes.removeAtIndex(self.index)
            
            // if empty-> go back
            if (self.appDelegate.memes.isEmpty) {
                self.navigationController?.popToRootViewControllerAnimated(true)
            }
            else {
                // select another image if not null
                if (self.index == 0) {
                    if (self.appDelegate.memes.count > 1) {
                        self.index = self.index + 1
                    }
                }
                else {
                    self.index = self.index - 1
                }
                // show new image
                self.imageView.image = self.appDelegate.memes[self.index].memedImage
                
            }
            

        }
        
        controller.addAction(deleteAction)
        
        // add cancel button
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.Cancel, handler: nil)
        
        controller.addAction(cancelAction)
        self.presentViewController(controller, animated: true, completion: nil)
        
        
        
    }

    // handle edit button
    @IBAction func editMeme(sender: UIBarButtonItem) {
        // get the edit meme controller
        let editMemeController = self.storyboard!.instantiateViewControllerWithIdentifier("EditMemeViewController") as! ViewController

        // set data
        editMemeController.topText = appDelegate.memes[index].topText
        editMemeController.bottomText = appDelegate.memes[index].bottomText
        editMemeController.memeImg = appDelegate.memes[index].ogImage
        // present controller
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
