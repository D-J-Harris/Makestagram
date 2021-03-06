//
//  UIImage+Size.swift
//  Makestagram
//
//  Created by Daniel Harris on 10/07/2018.
//  Copyright © 2018 Daniel Harris. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    var aspectHeight: CGFloat {
        let heightRatio = size.height/736
        let widthRatio = size.width/414
        let aspectRatio = fmax(heightRatio, widthRatio)
        
        return size.height/aspectRatio
    }
}
