//
//  ColorOptions.swift
//  FirebaseApp
//
//  Created by Masoud Sasha Desi on 4/7/19.
//  Copyright © Espy Team 8. All rights reserved.
//

import UIKit

var appTheme = ColorOptions(backgroundColorHex: 0xFFF4C4, textColorHex: 0x475F6C, navigationBarColorHex: 0xFCB65F)

struct ColorOptions{
    var background: UIColor
    var navigationBarText: UIColor
    var navigationBarBackground: UIColor
    
    init(backgroundColor: UIColor, textColor: UIColor, navigationBarColor: UIColor){
        background = backgroundColor
        navigationBarText = textColor
        navigationBarBackground = navigationBarColor
    }
    init(backgroundColorHex: UInt32, textColorHex: UInt32, navigationBarColorHex: UInt32){
        background = UIColorFromHex(rgbValue: backgroundColorHex)
        navigationBarText = UIColorFromHex(rgbValue: textColorHex)
        navigationBarBackground = UIColorFromHex(rgbValue: navigationBarColorHex)
    }
}

func UIColorFromHex(rgbValue: UInt32, alpha: Double = 1.0) -> UIColor{
    let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
    let green = CGFloat((rgbValue & 0x00FF00) >> 8)/256.0
    let blue = CGFloat((rgbValue & 0x0000FF))/256.0
    
    return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
}

func loadColors(viewController: UIViewController){
    viewController.view.backgroundColor = appTheme.background
    viewController.navigationController?.navigationBar.barTintColor = appTheme.navigationBarBackground
    viewController.navigationController?.navigationBar.tintColor = appTheme.navigationBarText
}
