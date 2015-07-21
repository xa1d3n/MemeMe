//
//  SentMemesCollectionViewController.swift
//  MemeMe
//
//  Created by Aldin Fajic on 6/6/15.
//  Copyright (c) 2015 Aldin Fajic. All rights reserved.
//

import UIKit

let reuseIdentifier = "cell"

class SentMemesCollectionViewController: UICollectionViewController {
    
    var memes: [Meme]!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // get memes
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        memes = appDelegate.memes
        collectionView?.reloadData()
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell : SentMemesCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! SentMemesCollectionViewCell
        
        let meme = memes[indexPath.row]
        cell.imageCell?.image = meme.memedImage
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // get details controller
        let detailController = storyboard!.instantiateViewControllerWithIdentifier("MemeDetailViewController") as! MemeDetailViewController
        // set details
        detailController.meme = memes[indexPath.row].memedImage
        detailController.index = indexPath.row
        // present controller
        navigationController!.pushViewController(detailController, animated: true)
    
    }

}
