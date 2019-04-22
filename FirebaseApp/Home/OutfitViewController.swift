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
        }
        
    }
    
    @IBOutlet weak var previousButtonClicked: UIButton!
    
    
    @IBOutlet weak var nextButtonClicked: UIButton!
    @IBOutlet weak var imageViewer: UIImageView!
    @IBAction func previousButton(_ sender: Any) {
        
        if(outfitIndex == 0)
        {
            imageViewer.image = Outfit.outfit_images[Outfit.outfitCounter - 1]
            outfitIndex = Outfit.outfitCounter - 1
        }
        else
        {
            outfitIndex = outfitIndex - 1
            imageViewer.image = Outfit.outfit_images[outfitIndex]
        }
        
    }
    
    @IBAction func nextButton(_ sender: Any) {
        
        if(outfitIndex == Outfit.outfit_images.count - 1)
        {
            imageViewer.image = Outfit.outfit_images[0]
            outfitIndex = 0
        }
        else
        {
            outfitIndex = outfitIndex + 1
            imageViewer.image = Outfit.outfit_images[outfitIndex]
        }
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
        
        // if image array has quantity 1 or is last element, this element being deleted
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
            outfitIndex = 0
            
            let data = [
                
                "topCount" : Outfit.topCounter,
                "bottomCount" : Outfit.bottomCounter,
                "shoesCount" : Outfit.shoesCounter,
                "outfitCount" : Outfit.outfitCounter
            ]
            
            Database.database().reference().child("user_data").child(Auth.auth().currentUser!.uid).updateChildValues(data)
        }
        

        
        if(Outfit.outfit_images.count > 0)
        {
            imageViewer.image = Outfit.outfit_images[0]
        }
        else
        {
            self.navigationController?.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
}
