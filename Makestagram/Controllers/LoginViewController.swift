//
//  LoginViewController.swift
//  Makestagram
//
//  Created by Daniel Harris on 06/07/2018.
//  Copyright © 2018 Daniel Harris. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseUI
import FirebaseDatabase

typealias FIRUser = FirebaseAuth.User

class LoginViewController : UIViewController {
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let authUI = FUIAuth.defaultAuthUI() else {return}
        
        authUI.delegate = self
        
        let authViewController = authUI.authViewController()
        present(authViewController, animated: true)
    }
}

extension LoginViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith user: FIRUser?, error: Error?) {
        //error handling
        if let error = error {
            assertionFailure("Error signing in: \(error.localizedDescription)")
            return
        }
        
        guard let user = user
            else {return}
        
        let userRef = Database.database().reference().child("users").child(user.uid)
        userRef.observeSingleEvent(of: .value, with: { (snapshot) in
            //retrieve user data from snapshot here
            if let user = User(snapshot: snapshot) {
                print("Welcome back \(user.username).")
            }
            else {
                self.performSegue(withIdentifier: "toCreateUsername", sender: self)
            }
        })
    }
}
