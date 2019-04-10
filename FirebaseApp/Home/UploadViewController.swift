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
    var tag : String = ""
    var fileName : String = "wardrobe.txt"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadColors(viewController: self)
        ImageView.image = previewImage
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func topPressed(_ sender: Any) {
        /*CHANGE TAG TO TOP*/
        tag = "top"
    }
    
    @IBAction func bottomPressed(_ sender: Any) {
        /*CHANGE TAG TO BOTTOM*/
        tag = "bottom"
    }
    
    @IBAction func shoesPressed(_ sender: Any) {
        /*CHANGE TAG TO SHOES*/
        tag = "shoes"
    }
    
    @IBAction func savePressed(_ sender: Any) {
        /*SAVE IMAGE AND RETURN TO MAIN MENU*/
        if tag != ""{
            let image = ImageView.image
            //convert image to string
            let imageData = image!.jpegData(compressionQuality: 0.01)! as Data
            let imageString = imageData.base64EncodedString(options: .endLineWithLineFeed)
            //save clothing item to wardrobe
            let newClothing = Clothing(inputTag: tag, inputImage: imageString)
            wardrobeItems.append(newClothing)
            //save clothing item to file
            saveToJSON(clothingArr: wardrobeItems, filename: "wardrobe")
            
            navigationController?.popViewController(animated: true)
            dismiss(animated: true, completion: nil)
        }
        else{
            print("no tag chosen")
        }
    }
}
