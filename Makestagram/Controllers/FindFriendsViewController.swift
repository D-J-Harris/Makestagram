//
//  FindFriendsViewController.swift
//  Makestagram
//
//  Created by Daniel Harris on 09/07/2018.
//  Copyright © 2018 Daniel Harris. All rights reserved.
//

import Foundation
import UIKit

class FindFriendsViewController: UIViewController {
    
    var users = [User]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserService.usersExcludingCurrentUser { [unowned self] (users) in
            self.users = users
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 71
    }
}

extension FindFriendsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FindFriendsCell") as! FindFriendsCell
        cell.delegate = self
        configureCell(cell: cell, atIndexPath: indexPath)
        
        return cell
    }
    
    func configureCell(cell: FindFriendsCell, atIndexPath indexPath: IndexPath) {
        let user = users[indexPath.row]
        
        cell.usernameLabel.text = user.username
        cell.followButton.isSelected = user.isFollowed
    }
}

extension FindFriendsViewController: FindFriendsCellDelegate {
    func didTapFollowButton(_ followButton: UIButton, on cell: FindFriendsCell) {
        guard let indexPath = tableView.indexPath(for: cell)
            else {
                return
        }
        
        followButton.isUserInteractionEnabled = false
        let followee = users[indexPath.row]
        
        FollowService.setIsFollowing(!followee.isFollowed, fromCurrentUserTo: followee) { (success) in
            defer {
                followButton.isUserInteractionEnabled = true
            }
            
            guard success else{ return }
            
            followee.isFollowed = !followee.isFollowed
            self.tableView.reloadRows(at: [indexPath], with: .none)
        }
    }
}
