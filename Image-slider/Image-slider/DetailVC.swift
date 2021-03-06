//
//  DetailVC.swift
//  Image-slider
//
//  Created by World Plus on 5/31/21.
//  Copyright © 2021 World Plus. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    
     
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let url = URL(string: imageUrl)
        
        self.productImageView.sd_setImage(with: url, placeholderImage: nil)
        self.productNameLabel.text = imageTitle
        self.detailLabel.text = imageDetail
    }
    
    @IBAction func closeBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
