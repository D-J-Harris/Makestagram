//
//  PostHeaderCell.swift
//  Makestagram
//
//  Created by Daniel Harris on 11/07/2018.
//  Copyright © 2018 Daniel Harris. All rights reserved.
//

import Foundation
import UIKit

class PostHeaderCell: UITableViewCell {
    
    static let height: CGFloat = 54
    
    @IBOutlet weak var usernameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    @IBAction func optionsButtonTapped(_ sender: UIButton) {
        print("Options button tapped")
    }
    
}
