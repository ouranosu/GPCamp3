//
//  RentalDetailViewController.swift
//  GPCamp3
//
//  Created by work on 2019/12/21.
//  Copyright © 2019 Masahiro Okura. All rights reserved.
//

import UIKit

class RentalDetailViewController: UIViewController {
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var detailLabel: UITextView!
    
    var image: UIImage!
    var name: String!
    var price: String!
    var detail: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.image = self.image
        nameLabel.text = self.name
        priceLabel.text = self.price
        detailLabel.text = self.detail
        self.overrideUserInterfaceStyle = .light
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        presentingViewController?.beginAppearanceTransition(true, animated: animated)
        presentingViewController?.endAppearanceTransition()
    }
}
