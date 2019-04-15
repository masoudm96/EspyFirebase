//
//  UploadViewController.swift
//  FirebaseApp
//
//  Created by Masoud Sasha on 4/7/19.
//  Copyright © 2019 Robert Canton. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class UploadViewController:UIViewController{
    
    @IBOutlet weak var topTagButton: UIButton!
    @IBOutlet weak var ImageView: UIImageView!
    var previewImage : UIImage?
    var data = Data()
    public var tag : String = ""
    var fileName : String = "wardrobe.txt"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ImageView.image = previewImage
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func topPressed(_ sender: Any) {
        /*CHANGE TAG TO TOP*/
        tag = "top"
        Clothing.key_tag = tag
        if tag == "top"{
            topTagButton.backgroundColor = UIColor.gray
        } else {
            topTagButton.backgroundColor = UIColor.clear
        }
    }
    
    @IBAction func bottomPressed(_ sender: Any) {
        /*CHANGE TAG TO BOTTOM*/
        tag = "bottom"
        Clothing.key_tag = tag
    }
    
    @IBAction func shoesPressed(_ sender: Any) {
        /*CHANGE TAG TO SHOES*/
        tag = "shoes"
        Clothing.key_tag = tag
    }
    
    
    @IBAction func savePressed(_ sender: Any) {
        if Clothing.key_tag != ""{
            //save image
            let image = ImageView.image
            guard let imageData = image?.jpegData(compressionQuality: 0.75) else { return }
            guard let user_email = Auth.auth().currentUser?.email else { return }
            
            let storageRef = Storage.storage().reference().child("\(user_email)").child("\(tag)").child("\(Clothing.top_images.count+1).jpg")
            
            
            let metaData = StorageMetadata()
            metaData.contentType = "image/jpg"
            
            //Upload image to Database
            storageRef.putData(imageData, metadata: nil, completion: {(metadata, Error) in
                print(metaData)
                
            //save URL for access of image later
            let downloadURL = metaData.downloadURL()
            //Update to the database with the new url
                let key = self.dbRef.childByAutoId().key
                let image = ["url": downloadURL?.absoluteString]
                
            self.navigationController?.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
            
            })
            
            if(Clothing.key_tag == "top")
            {
                Clothing.top_array.append(storageRef)
                Clothing.top_images.append(image!)
            }
                
            else if(Clothing.key_tag == "bottom")
            {
                Clothing.bottom_array.append(storageRef)
                Clothing.bottom_images.append(image!)

            }
            else
            {
                Clothing.shoes_array.append(storageRef)
                Clothing.shoes_images.append(image!)

            }
        }
        
        else{
            let alert = UIAlertController(title: "No Tag Chosen", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        }
    }
    
    struct Clothing{
        static var key_tag = String()
        static var top_array: [StorageReference] = []
        static var bottom_array: [StorageReference] = []
        static var shoes_array: [StorageReference] = []
        
        static var top_images: [UIImage] = []
        static var bottom_images: [UIImage] = []
        static var shoes_images: [UIImage] = []
    }
}
