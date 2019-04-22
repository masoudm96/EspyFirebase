//
//  JsonHandler.swift
//  FirebaseApp
//
//  Created by Masoud Sasha Desi on 4/7/19.
//  Copyright © Espy Team 8. All rights reserved.
//

import Foundation
import UIKit

struct Clothing : Codable{
    
    let tag : String
    let image : String
    
    init(inputTag: String, inputImage: String){
        tag = inputTag
        image = inputImage
    }
}

extension Array where Element == Clothing {
    init(filename: String) throws {
        self = try loadFromJSONFile(filename: filename)
    }
}

func loadFromJSONFile(filename: String) throws -> [Clothing]!{
    var clothingData:Data! = nil
    //find file
    var fileURL:URL!
    let baseURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    fileURL = baseURL.appendingPathComponent(filename).appendingPathExtension("json")
    //convert file to string
    let fileString = try! String(contentsOf: fileURL)
    //because the file is in base64, it must be decoded and converted back to data
    if let data = Data(base64Encoded: fileString, options: .ignoreUnknownCharacters) {
        let convertString = String(data: data, encoding: .utf8)
        clothingData = Data(convertString!.utf8)
    }
    //decode the data
    let clothingArr = decodeJSON(data: clothingData)
    
    return clothingArr
}

func saveToJSON(clothingArr: [Clothing], filename: String) {
    let wardrobe = encodeJSON(arr: clothingArr)
    var fileURL:URL!
    
    let baseURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
    fileURL = baseURL.appendingPathComponent(filename).appendingPathExtension("json")
    
    let dataString = wardrobe!.base64EncodedString(options: .endLineWithLineFeed)
    do{
        try dataString.write(to: fileURL, atomically: true, encoding: .utf8)
    }catch let error as NSError{
        print("Error saving to file: \(error.localizedDescription)")
    }
}

func encodeJSON(arr: [Clothing]!) -> Data!{
    var data:Data? = nil
    let encoder = JSONEncoder()
    data = try? encoder.encode(arr)
    
    return data
}

func decodeJSON(data: Data!) -> [Clothing]!{
    var arr:[Clothing]! = nil
    let decoder = JSONDecoder()
    
    do{
        try arr = decoder.decode([Clothing].self, from: data)
    }catch let error as NSError{
        print("Error Reading Json File \(error.localizedDescription)")
    }
    
    return arr
}

var wardrobeItems = [Clothing]()
