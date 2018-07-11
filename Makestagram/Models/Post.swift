//
//  Post.swift
//  Makestagram
//
//  Created by Daniel Harris on 10/07/2018.
//  Copyright © 2018 Daniel Harris. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase.FIRDataSnapshot

class Post {
    
    var dictValue: [String: Any] {
        let createdAgo = creationDate.timeIntervalSince1970
        return ["image_url": imageURL,
                "image_height": imageHeight,
                "createdAt": createdAgo]
    }
    
    var key: String?
    let imageURL: String
    let imageHeight: CGFloat
    let creationDate: Date
    
    init(imageURL: String, imageHeight: CGFloat) {
        self.imageURL = imageURL
        self.imageHeight = imageHeight
        self.creationDate = Date()
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String: Any],
        let imageURL = dict["image_url"] as? String,
        let imageHeight = dict["image_height"] as? CGFloat,
        let createdAgo = dict["createdAt"] as? TimeInterval
            else {return nil}
        
        self.key = snapshot.key
        self.imageURL = imageURL
        self.imageHeight = imageHeight
        self.creationDate = Date(timeIntervalSince1970: createdAgo)
    }
}
