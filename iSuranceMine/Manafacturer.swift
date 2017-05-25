//
//  Manafacturer.swift
//  iSuranceMine
//
//  Created by Abdullah Al Dhabaib on 5/14/17.
//  Copyright © 2017 Abdullah Al Dhabaib. All rights reserved.
//

import Foundation


class Manafacturer: NSObject {
    
    var name: String = ""
    var image_name: String = ""
    
    var info_complete: Bool = false

    var classifications: [CarClassification] = [CarClassification]()
    
}
