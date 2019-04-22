//
//  OuftifViewController.swift
//  FirebaseApp
//
//  Created by Masoud Sasha Desi on 4/7/19.
//  Copyright © Espy Team 8. All rights reserved.
//

import UIKit
import Firebase

class OutfitViewController: UIViewController {
    
    var outfitIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        self.tabBarController?.tabBar.isHidden = true
        
        if(Outfit.outfit_images.count == 0)
        {
            self.navigationController?.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
        }
        else{
            imageViewer.image = Outfit.outfit_images[outfitIndex]
            previousButtonClicked.isHidden = true
            if(Outfit.outfit_images.count == 1)
            {
                nextButtonClicked.isHidden = true
            }
        }
        
    }
    
    @IBOutlet weak var previousButtonClicked: UIButton!
    
    
    @IBOutlet weak var nextButtonClicked: UIButton!
    @IBOutlet weak var imageViewer: UIImageView!
    @IBAction func previousButton(_ sender: Any) {
        if(outfitIndex < Outfit.outfit_images.count && outfitIndex != 0)
        {
            outfitIndex = outfitIndex - 1
            imageViewer.image = Outfit.outfit_images[outfitIndex]
            if (outfitIndex == 0)
            {
                previousButtonClicked.isHidden = true
            }
            if( outfitIndex != Outfit.outfit_images.count - 1 )
            {
                nextButtonClicked.isHidden = false
                print("next button unhidden")
            }
        }
        
    }
    
    @IBAction func nextButton(_ sender: Any) {
        if(outfitIndex < Outfit.outfit_images.count)
        {
            outfitIndex = outfitIndex + 1
            imageViewer.image = Outfit.outfit_images[outfitIndex]
            if (outfitIndex == Outfit.outfit_images.count - 1)
            {
                nextButtonClicked.isHidden = true
            }
            if(outfitIndex > 0)
            {
                previousButtonClicked.isHidden = false
                print("previous button unhidden")
            }
            
        }
    }
    
    func reloadDatabase()
    {
        let ref = Database.database().reference().child("user_data").child(Auth.auth().currentUser!.uid)
        ref.observeSingleEvent(of: .value, with: { snapshot in
            
            if !snapshot.exists() { return }
            
            let top_number = snapshot.childSnapshot(forPath: "topCount").value
            let bottom_number = snapshot.childSnapshot(forPath: "bottomCount").value
            let shoes_number = snapshot.childSnapshot(forPath: "shoesCount").value
            let outfit_number = snapshot.childSnapshot(forPath: "outfitCount").value
            
            print("Top number: " + String((top_number as! Int)))
            print("Bottom number: " + String((bottom_number as! Int)))
            print("Shoes number: " + String((shoes_number as! Int)))
            print("Outfit number: " + String((outfit_number as! Int)))
            
            Outfit.topCounter = (top_number as! Int)
            Outfit.bottomCounter = bottom_number as! Int
            Outfit.shoesCounter = shoes_number as! Int
            Outfit.outfitCounter = outfit_number as! Int
        })
    }
    
    @IBAction func deleteOutfit(_ sender: Any) {
        // Declare Alert message
        let dialogMessage = UIAlertController(title: "Confirm", message: "Are you sure you want to delete this?", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            print("Ok button tapped")
            self.deleteRecord()
        })
        
        // Create Cancel button with action handlder
        let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (action) -> Void in
            print("Cancel button tapped")
        }
        
        //Add OK and Cancel button to dialog message
        dialogMessage.addAction(ok)
        dialogMessage.addAction(cancel)
        
        // Present dialog message to user
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    func deleteRecord()
    {
        guard let user_email = Auth.auth().currentUser?.email else { return }
        let storageRef = Storage.storage().reference().child("\(user_email)").child("/outfits")
        
        // if image array has quantity 1, this element being deleted
        if(outfitIndex == Outfit.outfit_images.count - 1)
        {
            // DELETING THE FILE
            // Create a reference to the file to delete
            let desertRef = storageRef.child("\(outfitIndex+1).jpg")
            
            // Delete the file
            desertRef.delete { error in
                if error != nil {
                    // Uh-oh, an error occurred!
                } else {
                    // File deleted successfully
                }
            }
            
            // DECREMENTING THE INDECIES
            Outfit.outfit_images.remove(at: outfitIndex)
            Outfit.outfitCounter = Outfit.outfitCounter - 1
            
            let data = [
                
                "topCount" : Outfit.topCounter,
                "bottomCount" : Outfit.bottomCounter,
                "shoesCount" : Outfit.shoesCounter,
                "outfitCount" : Outfit.outfitCounter
            ]
            
            Database.database().reference().child("user_data").child(Auth.auth().currentUser!.uid).updateChildValues(data)
        }
        
//        else if(outfitIndex < Outfit.outfit_images.count - 1)
//        {
//            // DELETING THE FILE
//            // Create a reference to the file to delete
//            let desertRef = storageRef.child("\(outfitIndex+1).jpg")
//
//            // Delete the file
//            desertRef.delete { error in
//                if error != nil {
//                    // Uh-oh, an error occurred!
//                } else {
//                    // File deleted successfully
//                }
//            }
//
//            // Create a reference to the file you want to download
//            let islandRef = storageRef.child("images/island.jpg")
//
//            // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
//            islandRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
//                if error != nil {
//                    // Uh-oh, an error occurred!
//                } else {
//                    // Data for "images/island.jpg" is returned
//                    let image = UIImage(data: data!)
//                }
//            }
//        }
        
        
        if(Outfit.outfit_images.count > 0)
        {
            imageViewer.image = Outfit.outfit_images[0]
            previousButtonClicked.isHidden = true
            if(Outfit.outfit_images.count == 1)
            {
                nextButtonClicked.isHidden = true
            }
        }
        else
        {
            self.navigationController?.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
}
