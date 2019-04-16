//
//  global.swift
//  FirebaseApp
//
//  Created by Masoud Sasha on 4/11/19.
//  Copyright © 2019 Robert Canton. All rights reserved.
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
    
    static var top_images: [UIImage] = []
    static var bottom_images: [UIImage] = []
    static var shoes_images: [UIImage] = []
    
    static var topCounter: Int = 0
    static var bottomCounter: Int = 0
    static var shoesCounter: Int = 0
}
