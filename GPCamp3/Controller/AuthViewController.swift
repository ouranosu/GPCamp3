//
//  AuthViewController.swift
//  GPCamp3
//
//  Created by work on 2020/03/05.
//  Copyright © 2020 Masahiro Okura. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseUI

class AuthViewController: UIViewController, FUIAuthDelegate {

    let authUI = FUIAuth.defaultAuthUI()
    let providers: [FUIAuthProvider] = [
        FUIEmailAuth(),
        FUIGoogleAuth()
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authUI?.delegate = self
        authUI?.providers = providers
        
        checkLoggedIn()
        
    }
    
    func authUI(_ authUI: FUIAuth, didSignInWith authDataResult: AuthDataResult?, error: Error?) {
        //認証画面FirebaseUIから離れた時に発動
        if error == nil {
            let NextViewController = (self.storyboard?.instantiateViewController(identifier: "HomeTab"))!
            self.present(NextViewController, animated: true, completion: nil)
        }
    }

    func checkLoggedIn(){
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                //チェックインしている
                let NextViewController = (self.storyboard?.instantiateViewController(identifier: "HomeTab"))!
                self.present(NextViewController, animated: true, completion: nil)
            } else {
                self.login()
            }
        }
    }
    
    func login(){
        let authViewController = authUI!.authViewController()
        self.present(authViewController, animated: true, completion: nil)
    }
}
