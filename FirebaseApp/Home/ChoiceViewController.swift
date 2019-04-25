//
//  ChoiceViewController.swift
//  FirebaseApp
//
//  Created by Masoud Sasha Desi on 4/7/19.
//  Copyright © Espy Team 8. All rights reserved.
//

import UIKit

class ChoiceViewController : UIViewController{
    
    @IBOutlet weak var galleryButton: UIButton!
    @IBOutlet weak var outfitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        self.tabBarController?.tabBar.isHidden = true
        
        //galleryButton.frame.origin = CGPoint(x: galleryButton.center.x, y: self.view.frame.height/3)
        //outfitButton.frame.origin = CGPoint(x: outfitButton.center.x, y: 2*self.view.frame.height/3)
        
    }
}
