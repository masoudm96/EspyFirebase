//
//  OutfitMakerViewController.swift
//  FirebaseApp
//
//  Created by Masoud Sasha Desi on 4/7/19.
//  Copyright © Espy Team 8. All rights reserved.
//

import Foundation
import Firebase
import UIKit

class OutfitMakerViewController:UIViewController{
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var shoesView: UIView!
    
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var bottomImageView: UIImageView!
    @IBOutlet weak var shoesImageView: UIImageView!
    
    var topIndex = 0
    var bottomIndex = 0
    var shoeIndex = 0
    var divisor:CGFloat!
    var padding:CGFloat = 0.0
    
    var headerSize:CGFloat = 0.0
    var origin = CGPoint(x: 0.0, y: 0.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        
        divisor = (view.frame.width / 2) / 0.61
        
        headerSize = UIScreen.main.bounds.size.height * 0.035
        origin = CGPoint(x: UIScreen.main.bounds.size.width*0.5, y: UIScreen.main.bounds.size.height*0.5 + headerSize)
        padding = (self.navigationController!.navigationBar.frame.height * 0.01) + bottomView.frame.size.height
        //padding = (UIScreen.main.bounds.size.height * 0.01) + bottomView.frame.size.height
        
        bottomView.center = CGPoint(x: origin.x, y: origin.y)
        topView.center = CGPoint(x: origin.x, y: origin.y - padding)
        shoesView.center = CGPoint(x: origin.x, y: origin.y + padding)
        
        if Outfit.top_images.isEmpty {
            print("No TOP image found")
        }else{
            topImageView.image = Outfit.top_images[0]
        }
        
        if Outfit.bottom_images.isEmpty {
            print("No BOTTOM image found")
        }else{
            bottomImageView.image = Outfit.bottom_images[0]
        }
        
        if Outfit.shoes_images.isEmpty {
            print("No SHOES image found")
        }else{
            shoesImageView.image = Outfit.shoes_images[0]
        }
    }
    
    @IBAction func panTop(_ sender: UIPanGestureRecognizer) {
        let card = sender.view!
        let point = sender.translation(in: view)
        let xFromCenter = card.center.x - view.center.x
        
        card.center = CGPoint(x: origin.x + point.x , y: origin.y - padding)
        card.transform = CGAffineTransform(rotationAngle: xFromCenter/divisor)
        
        if sender.state == .ended{
            if card.center.x < 50{ //Moved off to left
                UIView.animate(withDuration: 0.2,
                               animations: {
                                card.center = CGPoint(x: self.origin.x - 400, y: self.origin.y - self.padding - 200)
                                card.alpha = 0
                })
                card.center = CGPoint(x: self.origin.x + 400, y: self.origin.y - self.padding)
                card.transform = CGAffineTransform.identity
                //load next picture
                //check if out of bounds
                if( topIndex + 1 < Outfit.top_images.count ){
                    topIndex += 1
                    topImageView.image = Outfit.top_images[topIndex]
                }else{
                    print("All Images used")
                    topIndex = 0
                    topImageView.image = Outfit.top_images[0]
                }
                UIView.animate(withDuration: 0.2,
                               animations: {
                                card.center = CGPoint(x: self.origin.x, y: self.origin.y - self.padding)
                                card.alpha = 1
                                
                })
            }else if card.center.x > (view.frame.width - 50){ //Moved off to right
                UIView.animate(withDuration: 0.2,
                               animations: {card.center = CGPoint(x: self.origin.x + 400, y: self.origin.y - self.padding - 200)
                                card.alpha = 0
                })
                card.center = CGPoint(x: self.origin.x - 400, y: self.origin.y - self.padding)
                card.transform = CGAffineTransform.identity
                //load next picture
                //check if out of bounds
                if( topIndex + 1 < Outfit.top_images.count ){
                    topIndex += 1
                    topImageView.image = Outfit.top_images[topIndex]
                }else{
                    print("All Images used")
                    topIndex = 0
                    topImageView.image = Outfit.top_images[0]
                }
                UIView.animate(withDuration: 0.2,
                               animations: {
                                card.center = CGPoint(x: self.origin.x, y: self.origin.y - self.padding)
                                card.alpha = 1
                                
                })
            } else{
                UIView.animate(withDuration: 0.2, animations: {card.center = CGPoint(x: self.origin.x, y: self.origin.y - self.padding)
                    card.transform = CGAffineTransform.identity
                    
                })
                
            }
        }
    }
    
    @IBAction func panBottom(_ sender: UIPanGestureRecognizer) {
        let card = sender.view!
        let point = sender.translation(in: view)
        let xFromCenter = card.center.x - view.center.x
        
        card.center = CGPoint(x: origin.x + point.x , y: origin.y)
        card.transform = CGAffineTransform(rotationAngle: xFromCenter/divisor)
        
        if sender.state == .ended{
            if card.center.x < 50{
                UIView.animate(withDuration: 0.2,
                               animations: {card.center = CGPoint(x: self.origin.x - 400, y: self.origin.y - 35)
                                card.alpha = 0
                })
                card.center = CGPoint(x: self.origin.x + 400, y: self.origin.y)
                card.transform = CGAffineTransform.identity
                //load next picture
                //check if out of bounds
                if( bottomIndex + 1 < Outfit.bottom_images.count ){
                    bottomIndex += 1
                    bottomImageView.image = Outfit.bottom_images[bottomIndex]
                }else{
                    bottomIndex = 0
                    bottomImageView.image = Outfit.bottom_images[0]
                }
                UIView.animate(withDuration: 0.2,
                               animations: {
                                card.center = CGPoint(x: self.origin.x, y: self.origin.y)
                                card.alpha = 1
                                
                })
            }else if card.center.x > (view.frame.width - 50){
                UIView.animate(withDuration: 0.2,
                               animations: {card.center = CGPoint(x: self.origin.x + 400, y: self.origin.y - 35 )
                                card.alpha = 0
                })
                card.center = CGPoint(x: self.origin.x, y: self.origin.y)
                card.transform = CGAffineTransform.identity
                //load next picture
                //check if out of bounds
                if( bottomIndex + 1 < Outfit.bottom_images.count ){
                    bottomIndex += 1
                    bottomImageView.image = Outfit.bottom_images[bottomIndex]
                }else{
                    bottomIndex = 0
                    bottomImageView.image = Outfit.bottom_images[0]
                }
                UIView.animate(withDuration: 0.2,
                               animations: {
                                card.center = CGPoint(x: self.origin.x, y: self.origin.y)
                                card.alpha = 1
                                
                })
            } else{
                UIView.animate(withDuration: 0.2, animations: {card.center = CGPoint(x: self.origin.x, y: self.origin.y)
                    card.transform = CGAffineTransform.identity
                    
                })
            }
        }
    }
    @IBAction func panShoes(_ sender: UIPanGestureRecognizer) {
        let card = sender.view!
        let point = sender.translation(in: view)
        let xFromCenter = card.center.x - view.center.x
        
        card.center = CGPoint(x: origin.x + point.x , y: origin.y + padding)
        card.transform = CGAffineTransform(rotationAngle: xFromCenter/divisor)
        
        if sender.state == .ended{
            if card.center.x < 50{
                UIView.animate(withDuration: 0.2,
                               animations: {card.center = CGPoint(x: self.origin.x - 400, y: self.origin.y + self.padding + 200)
                                card.alpha = 0
                })
                card.center = CGPoint(x: self.origin.x + 400, y: self.origin.y + self.padding)
                card.transform = CGAffineTransform.identity
                if( shoeIndex + 1 < Outfit.shoes_images.count){
                    shoeIndex += 1
                    shoesImageView.image = Outfit.shoes_images[shoeIndex]
                }else{
                    shoeIndex = 0
                    shoesImageView.image = Outfit.shoes_images[0]
                }
                UIView.animate(withDuration: 0.2,
                               animations: {
                                card.center = CGPoint(x: self.origin.x, y: self.origin.y + self.padding)
                                card.alpha = 1
                                
                })
            }else if card.center.x > (view.frame.width - 50){
                UIView.animate(withDuration: 0.2,
                               animations: {card.center = CGPoint(x: self.origin.x + 400, y: self.origin.y + self.padding + 200)
                                card.alpha = 0
                })
                card.center = CGPoint(x: self.origin.x + 400, y: self.origin.y + padding)
                card.transform = CGAffineTransform.identity
                //load next picture
                //check if out of bounds
                if(shoeIndex + 1 < Outfit.shoes_images.count){
                    shoeIndex += 1
                    shoesImageView.image = Outfit.shoes_images[shoeIndex]
                }else{
                    shoeIndex = 0
                    shoesImageView.image = Outfit.shoes_images[0]
                }
                UIView.animate(withDuration: 0.2,
                               animations: {
                                card.center = CGPoint(x: self.origin.x, y: self.origin.y + self.padding)
                                card.alpha = 1
                })
            } else{
                UIView.animate(withDuration: 0.2, animations: {card.center = CGPoint(x: self.origin.x, y: self.origin.y + self.padding)
                    card.transform = CGAffineTransform.identity
                    
                })
            }
        }
    }
    
    @IBAction func saveOutfit(_ sender: Any) {
        let topImage = Outfit.top_images[topIndex]
        let bottomImage = Outfit.bottom_images[bottomIndex]
        let shoesImage = Outfit.shoes_images[shoeIndex]
        
        let size = CGSize(width: (topImage.size.width), height: (topImage.size.height) + (bottomImage.size.height) + (shoesImage.size.height))
        UIGraphicsBeginImageContextWithOptions(size, false, 0.0)
        
        topImage.draw(in: CGRect(x:0, y:0, width:size.width, height: (topImage.size.height)))
        bottomImage.draw(in: CGRect(x:0, y:(topImage.size.height), width: size.width,  height: (bottomImage.size.height)))
        shoesImage.draw(in: CGRect(x:0, y:(topImage.size.height + bottomImage.size.height), width: size.width,  height: (bottomImage.size.height)))
        
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        guard let user_email = Auth.auth().currentUser?.email else { return }
        let storageRef = Storage.storage().reference().child("\(user_email)").child("/outfits").child("\(Outfit.outfitCounter + 1).jpg")
        
        Outfit.outfitCounter = Outfit.outfitCounter + 1
        
        let data = [
            
            "topCount" : Outfit.topCounter,
            "bottomCount" : Outfit.bottomCounter,
            "shoesCount" : Outfit.shoesCounter,
            "outfitCount" : Outfit.outfitCounter
        ]
        
    Database.database().reference().child("user_data").child(Auth.auth().currentUser!.uid).updateChildValues(data)
        
        let imageData: NSData = newImage.jpegData(compressionQuality: 0.2)! as NSData
        //guard let imageData = newImage.jpegData(compressionQuality: 0.5) else { return }
        
        storageRef.putData(imageData as Data, metadata: nil, completion: {(metadata, Error) in
            print(metadata as Any)
            
            Outfit.outfit_array.append(storageRef)
            Outfit.outfit_images.append(newImage)
            
            self.navigationController?.popViewController(animated: true)
            self.dismiss(animated: true, completion: nil)
        })
    }
    @IBAction func randomButtonPressed(_ sender: Any) {
        topIndex = Int.random(in: 0 ..< Outfit.top_images.count)
        bottomIndex = Int.random(in: 0 ..< Outfit.bottom_images.count)
        shoeIndex = Int.random(in: 0 ..< Outfit.shoes_images.count)
        
        topImageView.image = Outfit.top_images[topIndex]
        bottomImageView.image = Outfit.bottom_images[bottomIndex]
        shoesImageView.image = Outfit.shoes_images[shoeIndex]
    }
}
