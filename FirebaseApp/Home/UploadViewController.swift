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
            let image = ImageView.image
            guard let imageData = image?.jpegData(compressionQuality: 0.75) else { return }
            guard let user_email = Auth.auth().currentUser?.email else { return }
            let storageRef = Storage.storage().reference().child("\(user_email)").child("\(tag)").child("\(Number(tag: tag)).jpg")
            
            
            let metaData = StorageMetadata()
            metaData.contentType = "image/jpg"
            storageRef.putData(imageData, metadata: nil, completion: {(metadata, Error) in
                print(metaData)
                
                // alerts don't popup, need to be fixed
                //let alert = UIAlertController(title: "Tag " + self.tag + " chosen", message: nil, preferredStyle: .alert)
                //alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                    //navigationController?.popViewController(animated: true)
                    //dismiss(animated: true, completion: nil)
            })
            
            if(Clothing.key_tag == "top")
            {
                Clothing.top_array.append(storageRef)
            }
                
            else if(Clothing.key_tag == "bottom")
            {
                Clothing.bottom_array.append(storageRef)
            }
            else
            {
                Clothing.shoes_array.append(storageRef)
            }
        }
        
        else{
            let alert = UIAlertController(title: "No Tag Chosen", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        }
    }
    
    // this will make sure every file uploaded will start with the value 1,
    // with respect to the tag chosen
    func Number(tag: String) -> Int{
        struct Value{
            static var topcounter = 0
            static var bottomcounter = 0
            static var shoescounter = 0
        }
        
        if(tag == "top")
        {
            Value.topcounter += 1
            return Value.topcounter
        }
        else if(tag == "bottom")
        {
            Value.bottomcounter += 1
            return Value.bottomcounter
        }
        else{
            Value.shoescounter += 1
            return Value.shoescounter
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
