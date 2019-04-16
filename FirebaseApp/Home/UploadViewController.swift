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
    var fileName : String = "wardrobe.txt"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ImageView.image = previewImage
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func topPressed(_ sender: Any) {
        /*CHANGE TAG TO TOP*/
        Outfit.key_tag = "top"
        if Outfit.key_tag == "top"{
            topTagButton.backgroundColor = UIColor.gray
        } else {
            topTagButton.backgroundColor = UIColor.clear
        }
    }
    
    @IBAction func bottomPressed(_ sender: Any) {
        /*CHANGE TAG TO BOTTOM*/
        Outfit.key_tag = "bottom"
        if Outfit.key_tag == "bottom"{
            topTagButton.backgroundColor = UIColor.gray
        } else {
            topTagButton.backgroundColor = UIColor.clear
        }
    }
    
    @IBAction func shoesPressed(_ sender: Any) {
        /*CHANGE TAG TO SHOES*/
        Outfit.key_tag = "shoes"
        if Outfit.key_tag == "shoes"{
            topTagButton.backgroundColor = UIColor.gray
        } else {
            topTagButton.backgroundColor = UIColor.clear
        }
    }
    
    
    @IBAction func savePressed(_ sender: Any) {
        if Outfit.key_tag != ""{
            let image = ImageView.image
            
            guard let imageData = image?.jpegData(compressionQuality: 0.75) else { return }
            guard let user_email = Auth.auth().currentUser?.email else { return }
            
            if(Outfit.key_tag == "top")
            {
                let storageRef = Storage.storage().reference().child("\(user_email)").child("\(Outfit.key_tag)").child("\(Int(Outfit.topCounter) + 1).jpg")
                
                Outfit.topCounter = Outfit.topCounter + 1
                
                let data = [
                    
                    "topCount" : Outfit.topCounter,
                    "bottomCount" : Outfit.bottomCounter,
                    "shoesCount" : Outfit.shoesCounter
                ]
                
            Database.database().reference().child("user_data").child(Auth.auth().currentUser!.uid).updateChildValues(data)
                
                
                let metaData = StorageMetadata()
                metaData.contentType = "image/jpg"
                
                storageRef.putData(imageData, metadata: nil, completion: {(metadata, Error) in
                    print(metaData)
                    
                    Outfit.top_array.append(storageRef)
                    Outfit.top_images.append(image!)
                    
                    self.navigationController?.popViewController(animated: true)
                    self.dismiss(animated: true, completion: nil)
                })
                
            }
                
            else if(Outfit.key_tag == "bottom")
            {
                let storageRef = Storage.storage().reference().child("\(user_email)").child("\(Outfit.key_tag)").child("\(Int(Outfit.bottomCounter) + 1).jpg")
                
                Outfit.bottomCounter = Outfit.bottomCounter + 1
                
                let data = [
                    
                    "topCount" : Outfit.topCounter,
                    "bottomCount" : Outfit.bottomCounter,
                    "shoesCount" : Outfit.shoesCounter
                ]
                
            Database.database().reference().child("user_data").child(Auth.auth().currentUser!.uid).updateChildValues(data)
                
                let metaData = StorageMetadata()
                metaData.contentType = "image/jpg"
                
                storageRef.putData(imageData, metadata: nil, completion: {(metadata, Error) in
                    print(metaData)
                    
                    Outfit.bottom_array.append(storageRef)
                    Outfit.bottom_images.append(image!)
                    
                    self.navigationController?.popViewController(animated: true)
                    self.dismiss(animated: true, completion: nil)
                })
            }
            else
            {
                let storageRef = Storage.storage().reference().child("\(user_email)").child("\(Outfit.key_tag)").child("\(Int(Outfit.shoesCounter) + 1).jpg")
                
                Outfit.shoesCounter = Outfit.shoesCounter + 1
                
                let data = [
                    
                    "topCount" : Outfit.topCounter,
                    "bottomCount" : Outfit.bottomCounter,
                    "shoesCount" : Outfit.shoesCounter
                ]
                
            Database.database().reference().child("user_data").child(Auth.auth().currentUser!.uid).updateChildValues(data)
                
                let metaData = StorageMetadata()
                metaData.contentType = "image/jpg"
                
                storageRef.putData(imageData, metadata: nil, completion: {(metadata, Error) in
                    print(metaData)
                    
                    Outfit.shoes_array.append(storageRef)
                    Outfit.shoes_images.append(image!)
                    
                    self.navigationController?.popViewController(animated: true)
                    self.dismiss(animated: true, completion: nil)
                })
            }
        }
        
        else{
           let alert = UIAlertController(title: "Alert", message: "No tag chosen", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                switch action.style{
                case .default:
                    print("default")
                    
                case .cancel:
                    print("cancel")
                    
                case .destructive:
                    print("destructive")
                    
                    
                }}))
        }
    }
}
