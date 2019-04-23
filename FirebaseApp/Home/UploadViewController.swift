//
//  UploadViewController.swift
//  FirebaseApp
//
//  Created by Masoud Sasha Desi on 4/7/19.
//  Copyright © Espy Team 8. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class UploadViewController:UIViewController{
    
    @IBOutlet weak var shoesTagButton: UIButton!
    @IBOutlet weak var bottomTagButton: UIButton!
    @IBOutlet weak var topTagButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
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
            bottomTagButton.backgroundColor = UIColor.gray
        } else {
            bottomTagButton.backgroundColor = UIColor.clear
        }
    }
    
    @IBAction func shoesPressed(_ sender: Any) {
        /*CHANGE TAG TO SHOES*/
        Outfit.key_tag = "shoes"
        if Outfit.key_tag == "shoes"{
            shoesTagButton.backgroundColor = UIColor.gray
        } else {
            shoesTagButton.backgroundColor = UIColor.clear
        }
    }
    
    
    @IBAction func savePressed(_ sender: Any) {
        saveButton.isUserInteractionEnabled = false
        saveButton.setTitle("Saving", for: .normal)
        if Outfit.key_tag != ""{
            let image = ImageView.image
            
            guard let imageData = image?.jpegData(compressionQuality: 0.75) else { return }
            guard let user_email = Auth.auth().currentUser?.email else { return }
            
            if(Outfit.key_tag == "top")
            {
                let ref = Database.database().reference().child("user_data").child(Auth.auth().currentUser!.uid)
                ref.observeSingleEvent(of: .value, with: { snapshot in
                    
                    if !snapshot.exists() { return }
                    
                    let top_number = snapshot.childSnapshot(forPath: "topCount").value
                    let bottom_number = snapshot.childSnapshot(forPath: "bottomCount").value
                    let shoes_number = snapshot.childSnapshot(forPath: "shoesCount").value
                    let outfit_number = snapshot.childSnapshot(forPath: "outfitCount").value
                    
                    Outfit.topCounter = (top_number as! Int)
                    Outfit.bottomCounter = bottom_number as! Int
                    Outfit.shoesCounter = shoes_number as! Int
                    Outfit.outfitCounter = outfit_number as! Int
                })
                
                let storageRef = Storage.storage().reference().child("\(user_email)").child("\(Outfit.key_tag)").child("\(Int(Outfit.topCounter) + 1).jpg")
                
                Outfit.topCounter = Outfit.topCounter + 1
                
                let data = [
                    
                    "topCount" : Outfit.topCounter,
                    "bottomCount" : Outfit.bottomCounter,
                    "shoesCount" : Outfit.shoesCounter,
                    "outfitCount" : Outfit.outfitCounter
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
                let ref = Database.database().reference().child("user_data").child(Auth.auth().currentUser!.uid)
                ref.observeSingleEvent(of: .value, with: { snapshot in
                    
                    if !snapshot.exists() { return }
                    
                    let top_number = snapshot.childSnapshot(forPath: "topCount").value
                    let bottom_number = snapshot.childSnapshot(forPath: "bottomCount").value
                    let shoes_number = snapshot.childSnapshot(forPath: "shoesCount").value
                    let outfit_number = snapshot.childSnapshot(forPath: "outfitCount").value
                    
                    Outfit.topCounter = (top_number as! Int)
                    Outfit.bottomCounter = bottom_number as! Int
                    Outfit.shoesCounter = shoes_number as! Int
                    Outfit.outfitCounter = outfit_number as! Int
                })
                
                
                
                
                let storageRef = Storage.storage().reference().child("\(user_email)").child("\(Outfit.key_tag)").child("\(Int(Outfit.bottomCounter) + 1).jpg")
                
                Outfit.bottomCounter = Outfit.bottomCounter + 1
                
                let data = [
                    
                    "topCount" : Outfit.topCounter,
                    "bottomCount" : Outfit.bottomCounter,
                    "shoesCount" : Outfit.shoesCounter,
                    "outfitCount" : Outfit.outfitCounter
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
                let ref = Database.database().reference().child("user_data").child(Auth.auth().currentUser!.uid)
                ref.observeSingleEvent(of: .value, with: { snapshot in
                    
                    if !snapshot.exists() { return }
                    
                    let top_number = snapshot.childSnapshot(forPath: "topCount").value
                    let bottom_number = snapshot.childSnapshot(forPath: "bottomCount").value
                    let shoes_number = snapshot.childSnapshot(forPath: "shoesCount").value
                    let outfit_number = snapshot.childSnapshot(forPath: "outfitCount").value
                    
                    Outfit.topCounter = (top_number as! Int)
                    Outfit.bottomCounter = bottom_number as! Int
                    Outfit.shoesCounter = shoes_number as! Int
                    Outfit.outfitCounter = outfit_number as! Int
                })
                
                
                
                
                
                let storageRef = Storage.storage().reference().child("\(user_email)").child("\(Outfit.key_tag)").child("\(Int(Outfit.shoesCounter) + 1).jpg")
                
                Outfit.shoesCounter = Outfit.shoesCounter + 1
                
                let data = [
                    
                    "topCount" : Outfit.topCounter,
                    "bottomCount" : Outfit.bottomCounter,
                    "shoesCount" : Outfit.shoesCounter,
                    "outfitCount" : Outfit.outfitCounter
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
        saveButton.setTitle("Save", for: .normal)
        saveButton.isUserInteractionEnabled = true
    }
}
