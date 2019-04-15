//
//  ChoiceViewController.swift
//  FirebaseApp
//
//  Created by dmcadmin on 4/14/19.
//  Copyright © 2019 Robert Canton. All rights reserved.
//

import UIKit

class ChoiceViewController : UIViewController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        self.tabBarController?.tabBar.isHidden = true
    }
}
