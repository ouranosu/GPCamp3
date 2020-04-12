//
//  InfoDetailViewController.swift
//  GPCamp3
//
//  Created by work on 2020/04/09.
//  Copyright © 2020 Masahiro Okura. All rights reserved.
//

import UIKit

class InfoDetailViewController: UIViewController {

    @IBOutlet weak var infoTitleLabel: UILabel!
    @IBOutlet weak var infoText: UITextView!
    
    var infoTitleString: String!
    var infoTextString: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //ダークモード回避
        self.overrideUserInterfaceStyle = .light
        
        //titleプロパティ
        infoTitleLabel.layer.cornerRadius = 10
        infoTitleLabel.clipsToBounds = true
        
        //textboxプロパティ
        infoText.layer.cornerRadius = 10
        infoText.clipsToBounds = true
        
        //テキストの改行
        let replaceText = self.infoTextString.replacingOccurrences(of: "\\n", with: "\n")
        
        infoTitleLabel.text = self.infoTitleString
        infoText.text = replaceText
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //画面遷移で戻る時、viewWillApperが呼ばれるようにするもの
        presentingViewController?.beginAppearanceTransition(true, animated: animated)
        presentingViewController?.endAppearanceTransition()
    }

}
