//
//  HomeViewController.swift
//  FirebaseApp
//
//  Created by Masoud Sasha Desi on 4/7/19.
//  Copyright © Espy Team 8. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class HomeViewController:UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    var image : UIImage?
    var dataBuffer : Data?
    var tagBuffer : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.sendAction(#selector(UIApplication.resignFirstResponder), to: nil, from: nil, for: nil)
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        self.tabBarController?.tabBar.isHidden = true
        
        //loading annimation button
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
        
        loadImagesFromDataBase()
        
        // dismiss animation
        dismiss(animated: false, completion: nil)
        //print("Number of Images Found in top: \(Outfit.top_images.count)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    @IBAction func handleLogout(_ sender:Any) {
        Outfit.topCounter = 0
        Outfit.bottomCounter = 0
        Outfit.shoesCounter = 0
        Outfit.outfitCounter = 0
        
        Outfit.top_images.removeAll()
        Outfit.bottom_images.removeAll()
        Outfit.shoes_images.removeAll()
        Outfit.outfit_images.removeAll()
        
        Outfit.top_array.removeAll()
        Outfit.bottom_array.removeAll()
        Outfit.shoes_array.removeAll()
        
        try! Auth.auth().signOut()
    }
    
    
    @IBAction func chooseImage(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a Source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera)
            {
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
                imagePickerController.allowsEditing = true
            }
            else
            {
                print("Camera not available")
            }
            
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in imagePickerController.sourceType = .photoLibrary
            imagePickerController.allowsEditing = true
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    
    @IBAction func wardrobePressed(_ sender: Any) {
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        if let croppedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage{
            image = croppedImage
        }
        else if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            image = originalImage
        }
        
        performSegue(withIdentifier: "segueToUpload", sender: Any?.self)
        picker.dismiss(animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let nextController = segue.destination as? UploadViewController {
            nextController.previewImage = image
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func loadImagesFromDataBase(){
        var bufferImage = UIImage(named: "question.png")
        var file_string:String?
        var reference:StorageReference?
        
        guard let user_email = Auth.auth().currentUser?.email else { return }
        let storageRef = Storage.storage().reference().child("\(user_email)")
        
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
            
            Outfit.top_images = [UIImage](repeating: bufferImage!, count: Outfit.topCounter)
            Outfit.bottom_images = [UIImage](repeating: bufferImage!, count: Outfit.bottomCounter)
            Outfit.shoes_images = [UIImage](repeating: bufferImage!, count: Outfit.shoesCounter)
            Outfit.outfit_images = [UIImage](repeating: bufferImage!, count: Outfit.outfitCounter)
            
            if(Outfit.topCounter > 0){
                for i in 0 ... Outfit.topCounter - 1{
                    // Reference to an image file in Firebase Storage
                    file_string = String(i+1) + ".jpg"
                    reference = storageRef.child("/top").child(file_string!)
                    reference!.getData(maxSize: 1 * 4096 * 4096) {data, error in
                        if error != nil {
                            print(error!)
                        } else {
                            //print("Top Image: " + file_string!)
                            bufferImage = UIImage(data: data!)!
                            
                            //Outfit.top_images.append(bufferImage!)
                            Outfit.top_images[i] = bufferImage!
                        }
                    }
                }
            }
            
            if(Outfit.bottomCounter > 0){
                for i in 0 ... Outfit.bottomCounter - 1{
                    // Reference to an image file in Firebase Storage
                    file_string = String(i+1) + ".jpg"
                    reference = storageRef.child("/bottom").child(file_string!)
                    reference!.getData(maxSize: 1 * 4096 * 4096) {data, error in
                        if error != nil {
                            print(error!)
                        } else {
                            //print("Bottom Image: " + file_string!)
                            bufferImage = UIImage(data: data!)!
                            
                            //Outfit.bottom_images.append(bufferImage!)
                            Outfit.bottom_images[i] = bufferImage!
                        }
                    }
                }
            }
            
            if(Outfit.shoesCounter > 0){
                for i in 0 ... Outfit.shoesCounter - 1 {
                    // Reference to an image file in Firebase Storage
                    file_string = String(i+1) + ".jpg"
                    reference = storageRef.child("/shoes").child(file_string!)
                    reference!.getData(maxSize: 1 * 4096 * 4096) {data, error in
                        if error != nil {
                            print(error!)
                        } else {
                            //print("Shoes Image: " + file_string!)
                            bufferImage = UIImage(data: data!)!
                            
                            //Outfit.shoes_images.append(bufferImage!)
                            Outfit.shoes_images[i] = bufferImage!
                        }
                    }
                }
            }
            
            if(Outfit.outfitCounter > 0){
                for i in 0 ... Outfit.outfitCounter - 1 {
                    // Reference to an image file in Firebase Storage
                    file_string = String(i+1) + ".jpg"
                    reference = storageRef.child("/outfits").child(file_string!)
                    reference!.getData(maxSize: 1 * 4096 * 4096) {data, error in
                        if error != nil {
                            print(error!)
                        } else {
                            //print("Shoes Image: " + file_string!)
                            bufferImage = UIImage(data: data!)!
                            
                            //Outfit.outfit_images.append(bufferImage!)
                            Outfit.outfit_images[i] = bufferImage!
                        }
                    }
                }
            }
        })
        
    }
    
    private func loadImageFromDatabaseIndex(imageNum: Int) -> UIImage
    {
        var image:UIImage? = nil
        guard let user_email = Auth.auth().currentUser?.email else { return image! }
        let storageRef = Storage.storage().reference()
        
        // Reference to an image file in Firebase Storage
        let file_string = String(imageNum + 1) + ".jpg"
        let reference = storageRef.child("\(user_email)").child("/top").child(file_string)
        
        reference.getData(maxSize: 1 * 4096 * 4096) {data, error in
            if error != nil {
                print("Error finding image \(imageNum + 1)")
            } else {
                image = UIImage(data: data!)!
            }
        }
        while( image == nil ){
            
        }
        return image!
    }
}
