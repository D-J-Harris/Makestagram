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
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = posts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostImageCell", for: indexPath) as! PostImageCell
        
        let imageURL = URL(string: post.imageURL)
        cell.postImageView.kf.setImage(with: imageURL)
        
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let post = posts[indexPath.row]
        
        return post.imageHeight
    }
}
