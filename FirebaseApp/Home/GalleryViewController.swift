//
//  GalleryViewController.swift
//  FirebaseApp
//
//  Created by Masoud Sasha on 4/7/19.
//  Copyright © 2019 Robert Canton. All rights reserved.
//

import Foundation
import Firebase
import UIKit
import FirebaseUI

class GalleryViewController:UIViewController{
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var rawImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        self.tabBarController?.tabBar.isHidden = true
        if UploadViewController.Clothing.top_images.count > 0{
            imageView.image = UploadViewController.Clothing.top_images.last
        }
    }
}
