//
//  QuestionViewController.swift
//  GPCamp3
//
//  Created by work on 2020/02/02.
//  Copyright © 2020 Masahiro Okura. All rights reserved.
//

import UIKit
import WebKit

class QuestionViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    fileprivate let url: URL = URL(string: "https://forms.gle/rv41HCkai5tgNt1Y9")!

    var isGoNextDisplay: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UIApplication.shared.canOpenURL(url){
            UIApplication.shared.open(url)
            isGoNextDisplay = true
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if isGoNextDisplay == true {
            isGoNextDisplay = false
            self.dismiss(animated: true, completion: nil)
        }
    }

}
