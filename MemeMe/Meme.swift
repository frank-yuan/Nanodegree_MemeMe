//
//  Meme.swift
//  MemeMe
//
//  Created by Xuan Yuan (Frank) on 7/19/16.
//  Copyright © 2016 frank-yuan. All rights reserved.
//

import UIKit

struct Meme {

    var topText: String
    var bottomText: String
    let image: UIImage
    var memedImage: UIImage
    

    static func getMemeArray() -> [Meme] {
        return (UIApplication.sharedApplication().delegate as! AppDelegate).memes
    }
}
