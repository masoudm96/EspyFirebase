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
   
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!
    @IBOutlet weak var imageView4: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        self.tabBarController?.tabBar.isHidden = true
        print(Outfit.top_images.count)
        if Outfit.top_images.count > 0{
            imageView1.image = Outfit.top_images[0]
            imageView2.image = Outfit.top_images[1]
            imageView3.image = Outfit.top_images[2]
            imageView4.image = Outfit.top_images[3
            ]
        }
    }
}
