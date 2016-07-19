//
//  Meme.swift
//  MemeMe
//
//  Created by Xuan Yuan (Frank) on 7/19/16.
//  Copyright © 2016 frank-yuan. All rights reserved.
//

import UIKit

class Meme {

    let topText: String
    let bottomText: String
    let image: UIImage
    let memedImage: UIImage
    
    init(topText:String, bottomText:String, image: UIImage, memedImage: UIImage)
    {
        self.image = image
        self.memedImage = memedImage
        self.topText = topText
        self.bottomText = bottomText

    }
}
