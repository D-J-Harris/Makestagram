//
//  HomeViewController.swift
//  Makestagram
//
//  Created by Daniel Harris on 09/07/2018.
//  Copyright © 2018 Daniel Harris. All rights reserved.
//

import Foundation
import UIKit
import Kingfisher

class HomeViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    //Properties
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        
        UserService.posts(for: User.current) { (posts) in
            self.posts = posts
            self.tableView.reloadData()
        }
    }
    
    func configureTableView() {
        //remove empty cell separators
        tableView.tableFooterView = UIView()
        //remove separators from cells
        tableView.separatorStyle = .none
    }
}

//UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.section]
        
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostHeaderCell", for: indexPath) as! PostHeaderCell
            cell.usernameLabel.text = User.current.username
            return cell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostImageCell", for: indexPath) as! PostImageCell
            let imageURL = URL(string: post.imageURL)
            cell.postImageView.kf.setImage(with: imageURL)
            return cell
            
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostActionCell", for: indexPath) as! PostActionCell
            return cell
        default:
            fatalError("Error: Unexpected index path.")
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.row {
        case 0:
            return PostHeaderCell.height
        case 1:
            let post = posts[indexPath.section]
            return post.imageHeight
        case 2:
            return PostActionCell.height
        default:
            fatalError()
        }
    }
}
