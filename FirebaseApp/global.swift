//
//  global.swift
//  FirebaseApp
//
//  Created by Masoud Sasha Desi on 4/7/19.
//  Copyright © Espy Team 8. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import FirebaseUI

class Outfit{
    static var key_tag = String()
    static var top_array: [StorageReference] = []
    static var bottom_array: [StorageReference] = []
    static var shoes_array: [StorageReference] = []
    static var outfit_array: [StorageReference] = []
    
    static var top_images: [UIImage] = []
    static var bottom_images: [UIImage] = []
    static var shoes_images: [UIImage] = []
    static var outfit_images: [UIImage] = []
    
    static var topCounter: Int = 0
    static var bottomCounter: Int = 0
    static var shoesCounter: Int = 0
    static var outfitCounter: Int = 0
}
