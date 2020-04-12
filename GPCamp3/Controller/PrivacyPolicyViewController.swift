//
//  PrivacyPolicyViewController.swift
//  GPCamp3
//
//  Created by work on 2020/04/06.
//  Copyright © 2020 Masahiro Okura. All rights reserved.
//

import UIKit

class PrivacyPolicyViewController: UIViewController, UITextViewDelegate {

    let scrolleView = UIScrollView()
    let textView = UITextView()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.overrideUserInterfaceStyle = .light
    /*
        //UIScrollViewのインスタンス
        scrolleView.frame = self.view.frame
        scrolleView.contentSize = CGSize(width: self.view.frame.width, height: 1000)
        self.view.addSubview(scrolleView)
    */
        //UITextViewのインスタンス
        textView.delegate = self
        textView.textColor = .black
        self.view.addSubview(textView)
        //scrolleView.addSubview(textView)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        //textView.frame = CGRect(x: 0, y: 0, width: scrolleView.frame.width, height: scrolleView.frame.height)
        textView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        textView.text = privacyPolicy().policyText
    }

}
