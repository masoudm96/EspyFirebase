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
        reloadDatabase()
        imageViewer.image = Outfit.outfit_images[outfitIndex]
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        self.tabBarController?.tabBar.isHidden = true
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
    
    
    
}
