//
//  PhotosListModel.swift
//  Mansur Media
//
//  Created by Mansur on 30/08/20.
//  Copyright © 2020 MansurBagwan. All rights reserved.
//

import UIKit

class PhotosListModel: NSObject, NSCoding {
    
    var format: String!
    var width, height: Int!
    var filename: String!
    var id: Int!
    var author: String!
    var authorURL, postURL: String!
    
    init(fromDictinory dictinary:[String:Any]){
        
        let utilityObject = CommonUtility()
        
        if let format = dictinary["format"]
        {
            if (utilityObject.hasValue(object: format as AnyObject)) {
                self.format = format as? String
            }
        }
        
        if let width = dictinary["width"]
        {
            if (utilityObject.hasValue(object: width as AnyObject)) {
                self.width = width as? Int
            }
        }
        
        if let height = dictinary["height"]
        {
            if (utilityObject.hasValue(object: height as AnyObject)) {
                self.height = height as? Int
            }
        }
        
        if let filename = dictinary["filename"]
        {
            if (utilityObject.hasValue(object: filename as AnyObject)) {
                self.filename = filename as? String
            }
        }
        
        if let id = dictinary["id"]
        {
            if (utilityObject.hasValue(object: id as AnyObject)) {
                self.id = id as? Int
            }
        }
        
        if let author = dictinary["author"]
        {
            if (utilityObject.hasValue(object: author as AnyObject)) {
                self.author = author as? String
            }
        }
        
        if let authorURL = dictinary["authorURL"]
        {
            if (utilityObject.hasValue(object: authorURL as AnyObject)) {
                self.authorURL = authorURL as? String
            }
        }
        
        if let postURL = dictinary["postURL"]
        {
            if (utilityObject.hasValue(object: postURL as AnyObject)) {
                self.postURL = postURL as? String
            }
        }
    }
    func toDictionary() -> [String:Any] {
        
        var dictionary = [String:Any]()
        
        if format != nil {
            dictionary["format"] = format
        }
        if width != nil {
            dictionary["width"] = width
        }
        if height != nil {
            dictionary["height"] = height
        }
        if filename != nil {
            dictionary["filename"] = filename
        }
        if id != nil {
            dictionary["id"] = id
        }
        if author != nil {
            dictionary["author"] = author
        }
        if authorURL != nil {
            dictionary["authorURL"] = authorURL
        }
        if postURL != nil {
            dictionary["postURL"] = postURL
        }
        
        return dictionary
        
    }
    @objc required init(coder aDecoder: NSCoder)
    {
        format = aDecoder.decodeObject(forKey: "format") as? String
        width = aDecoder.decodeObject(forKey: "width") as? Int
        height = aDecoder.decodeObject(forKey: "height") as? Int
        filename = aDecoder.decodeObject(forKey: "filename") as? String
        id = aDecoder.decodeObject(forKey: "id") as? Int
        author = aDecoder.decodeObject(forKey: "author") as? String
        authorURL = aDecoder.decodeObject(forKey: "authorURL") as? String
        postURL = aDecoder.decodeObject(forKey: "postURL") as? String
    }
    
    @objc func encode(with aCoder: NSCoder) {
        
        if format != nil
        {
            aCoder.encode(format, forKey: "format")
        }
        if width != nil
        {
            aCoder.encode(width, forKey: "width")
        }
        if height != nil
        {
            aCoder.encode(height, forKey: "height")
        }
        if filename != nil
        {
            aCoder.encode(filename, forKey: "filename")
        }
        if id != nil
        {
            aCoder.encode(id, forKey: "id")
        }
        if author != nil
        {
            aCoder.encode(author, forKey: "author")
        }
        if authorURL != nil
        {
            aCoder.encode(authorURL, forKey: "authorURL")
        }
        if postURL != nil
        {
            aCoder.encode(postURL, forKey: "postURL")
        }
    }
    
    
    
    
    
    
    

}
