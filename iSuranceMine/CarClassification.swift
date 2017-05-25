//
//  CarClassification.swift
//  iSuranceMine
//
//  Created by Abdullah Al Dhabaib on 5/11/17.
//  Copyright © 2017 Abdullah Al Dhabaib. All rights reserved.
//

import Foundation
import Firebase

class CarClassification : NSObject {
    
    var make : String = "N/A"
    var type: String = "N/A"
    var year: String = "N/A"
    var price_range: String = "N/A"
    var rate : String = "N/A"
    var insurance_company : String = "N/A"
   
    var fileCost:String =  "N/A"
    var usauge:String = "N/A"
    var majhool:String  = "N/A"
    var majhool_2:String = "N/A"
    var majhool_3:String = "N/A"
    var fix_inside:String = "N/A"
    var fix_outside:String = "N/A"
    
    var windowPercent = "N/A"
    var windowFix_outside = "false"
    var windowFix_inside = "false"
    var roadsideCost = "N/A"
    
    var day0_1_price = "0"
    var day0_2_price = "0"
    var day0_3_price = "0"
    
    var day1_1_price = "0"
    var day1_2_price = "0"
    var day1_3_price = "0"
    
    var day2_1_price = "0"
    var day2_2_price = "0"
    var day2_3_price = "0"
    
    var civilRight = "N/A"
    var returnRight = "N/A"
    
    
    func uploadToDatabase(){
        
        // FireBase Reference
        let ref =  FIRDatabase.database().reference().child(self.insurance_company).child(self.make).childByAutoId()
        
        // Set Values
        let newClientData = [
            "make" : self.make,
            "type": self.type,
            "year": self.year,
            "price_range": self.price_range,
            "rate": self.rate,
            "fileCost": self.fileCost,
            "usauge": self.usauge,
            "majhool": self.majhool,
            "majhool_2": self.majhool_2,
            "majhool_3": self.majhool_3,
            "fix_outside": self.fix_outside,
            "fix_inside": self.fix_inside,
            "windowPercent": self.windowPercent,
            "windowFix_outside": self.windowFix_outside,
            "windowFix_inside": self.windowFix_inside,
            "roadsideCost": self.roadsideCost,
            "day0_1_price": self.day0_1_price,
            "day0_2_price": self.day0_2_price,
            "day0_3_price": self.day0_3_price,
            "day1_1_price": self.day1_1_price,
            "day1_2_price": self.day1_2_price,
            "day1_3_price": self.day1_3_price,
            "day2_1_price": self.day2_1_price,
            "day2_2_price": self.day2_2_price,
            "day2_3_price": self.day2_3_price,
            "civilRight": self.civilRight,
            "returnRight": self.returnRight]
        
        ref.setValue(newClientData, withCompletionBlock:   { (NSError, FIRDatabaseReference) in
            
            print("\t*** CarClassfication: uploaded classification to DataBase ***\n")
            
            DispatchQueue.main.async {
                 NotificationCenter.default.post(name: Notification.Name("Uploaded"), object: nil)
           
            }

        })
        
    }
    
    
    
}
