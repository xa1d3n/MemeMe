//
//  Meme.swift
//  MemeMe
//
//  Created by Aldin Fajic on 6/4/15.
//  Copyright (c) 2015 Aldin Fajic. All rights reserved.
//

import Foundation
import UIKit

struct Meme {
    var topText: String
    var bottomText: String
    var ogImage: UIImage
    var memedImage: UIImage
    
    init(topText: String, bottomText: String, ogImage: UIImage, memedImage: UIImage) {
        self.topText = topText
        self.bottomText = bottomText
        self.ogImage = ogImage
        self.memedImage = memedImage
    }
}
