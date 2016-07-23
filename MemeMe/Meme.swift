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
    
    static var sharedMemes = [Meme]()

    static let savedFileName = "meme.dat"
    
    // MARK: Helper class for serialization as we cannot serialize a struct directly
    private class MemeHashtable : NSObject, NSCoding {
        
        var data : NSMutableDictionary
        
        init(meme:Meme) {
            data = NSMutableDictionary()
            data.setValue(meme.topText, forKey: "topText")
            data.setValue(meme.bottomText, forKey: "bottomText")
            data.setValue(meme.image, forKey: "image")
            data.setValue(meme.memedImage, forKey: "memedImage")
        }
        
        func toMeme() -> Meme {
            return Meme(
                topText : (data["topText"] as? String)!,
                bottomText : (data["bottomText"] as? String)!,
                image : (data["image"] as? UIImage)!,
                memedImage : (data["memedImage"] as? UIImage)!
            )
        }
        
        // MARK: Protocol for NSCoding
        @objc func encodeWithCoder(aCoder: NSCoder) {
            for entry in data {
                aCoder.encodeObject(entry.value, forKey: entry.key as! String)
            }
        }
        
        @objc required init?(coder aDecoder: NSCoder) { // NS_DESIGNATED_INITIALIZER
            data = NSMutableDictionary()
            data.setValue(aDecoder.decodeObjectForKey("topText"), forKey: "topText")
            data.setValue(aDecoder.decodeObjectForKey("bottomText"), forKey: "bottomText")
            data.setValue(aDecoder.decodeObjectForKey("image"), forKey: "image")
            data.setValue(aDecoder.decodeObjectForKey("memedImage"), forKey: "memedImage")
        }


    }
    
    static func getMemeArray() -> [Meme]{
        return sharedMemes
    }
    
    static func saveMemeToStorage() {
        let fileName = getDocumentFilePath(savedFileName)
        let arrayToSave = NSMutableArray()
        for meme in getMemeArray() {
            arrayToSave.addObject(MemeHashtable(meme: meme))
        }
        NSKeyedArchiver.archiveRootObject(arrayToSave, toFile: fileName)
    }
    
    static func loadMemeFromStorage() {
        
        sharedMemes.removeAll()
        
        if let loadedObj = NSKeyedUnarchiver.unarchiveObjectWithFile(getDocumentFilePath(savedFileName)) {
            let arrayToLoad =  loadedObj as! NSMutableArray
            for obj in arrayToLoad {
                sharedMemes.append((obj as! MemeHashtable).toMeme())
            }
        }
    }
    
    static func getDocumentFilePath(fileName:String) -> String {
        let paths = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory.stringByAppendingString("/"+fileName)
    }

}
