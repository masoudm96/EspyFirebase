//
//  GalleryViewController.swift
//  FirebaseApp
//
//  Created by Masoud Sasha Desi on 4/7/19.
//  Copyright © Espy Team 8. All rights reserved.
//

import Foundation
import Firebase
import UIKit
import FirebaseUI

class GalleryViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    var allImages : NSMutableArray!
    
    var sections = ["Top", "Bottom", "Shoe"]
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        var reuseable : UICollectionReusableView? = nil
        if(kind == UICollectionView.elementKindSectionHeader){
            let view = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "ReuseableView", for: indexPath) as! ReuseableCollectionReusableView
            
            view.sectionHeader.text = sections[indexPath.section]
            
            reuseable = view
        }
        return reuseable!
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (allImages.object(at: section) as! NSArray).count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CollectionViewCell
        let cellSize = cell.frame.size.width
    
        cell.clothingImageView.frame = CGRect(x: cellSize * 0.05, y: cellSize * 0.05, width: cellSize * 0.9, height: cellSize * 0.9)
        
        if(indexPath.section == 0){
            cell.clothingImageView.image = Outfit.top_images[indexPath.row]
        }
        else if (indexPath.section == 1){
            cell.clothingImageView.image = Outfit.bottom_images[indexPath.row]
        }else{
            cell.clothingImageView.image = Outfit.shoes_images[indexPath.row]
        }
        cell.layer.backgroundColor = UIColor.white.cgColor
        cell.layer.cornerRadius = 5
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 1
        
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        self.tabBarController?.tabBar.isHidden = true
        
        allImages = NSMutableArray(array: [Outfit.top_images, Outfit.bottom_images, Outfit.shoes_images])
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.sectionInset = UIEdgeInsets (top: 0, left: 5, bottom: 0, right: 5)
        layout.minimumInteritemSpacing = 5
        layout.itemSize = CGSize(width: (self.view.frame.size.width - 15)/2, height: (self.view.frame.size.width - 15)/2)

        //layout.minimumInteritemSpacing = 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.blue.cgColor
        cell?.layer.borderWidth = 5
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        
        cell?.layer.borderColor = UIColor.lightGray.cgColor
        cell?.layer.borderWidth = 1
    }
}

