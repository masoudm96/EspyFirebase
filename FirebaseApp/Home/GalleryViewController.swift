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
        retrievePicture()
    }
    
    func retrievePicture()
    {
        guard let user_email = Auth.auth().currentUser?.email else { return }
        let storageRef = Storage.storage().reference()
        
        // Reference to an image file in Firebase Storage
        let reference = storageRef.child("\(user_email)").child("/top").child("1.jpg")
        
        // UIImageView in your ViewController
        let imageView: UIImageView = self.imageView
        
        // Placeholder image
        let placeholderImage = UIImage(named: "placeholder.jpg")
        //UploadViewController.Clothing.top_images.append(<#UIImage#>)
        
        // Load the image using SDWebImage
        imageView.sd_setImage(with: reference, placeholderImage: placeholderImage)
        UploadViewController.Clothing.top_images.append(imageView.image!)
            rawImage.image = UploadViewController.Clothing.top_images[0]
        //imageView.image = UploadViewController.Clothing.top_images[0]
    }
}
