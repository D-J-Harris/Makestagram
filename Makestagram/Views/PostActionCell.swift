//
//  PostActionCell.swift
//  Makestagram
//
//  Created by Daniel Harris on 11/07/2018.
//  Copyright © 2018 Daniel Harris. All rights reserved.
//

import Foundation
import UIKit

class PostActionCell: UITableViewCell {
    
    static let height: CGFloat = 46
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeCountLabel: UILabel!
    @IBOutlet weak var timeAgoLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        print("Like button tapped")
    }
}
