//
//  Country.swift
//  iSuranceMine
//
//  Created by Abdullah Al Dhabaib on 5/14/17.
//  Copyright © 2017 Abdullah Al Dhabaib. All rights reserved.
//

import Foundation


class Country: NSObject {
    
    var name: String = ""
    var image_name: String = ""
    var manafacturers: [Manafacturer] = [Manafacturer]()
    var info_complete: Bool = false
    
    
    func setupCountry(name:String, image_name:String, man_names:[String] , man_image_names:[String]){
        
        
        // (I)Country Creation
        
        self.name =  name
        self.image_name = image_name
        self.info_complete = false
        
        
        // (II)  Manfacturer Creation
        var index = 0
        for _ in 0..<man_names.count {
            
            let man = Manafacturer()
            man.name = man_names[index]
            man.image_name = man_image_names[index]
            self.manafacturers.append(man)
            index = index + 1
        }
        
    }
    
    
    
}
