//
//  InsuranceCompany.swift
//  iSuranceMine
//
//  Created by Abdullah Al Dhabaib on 5/14/17.
//  Copyright © 2017 Abdullah Al Dhabaib. All rights reserved.
//

import Foundation


class InsuranceCompany: NSObject {
    
    var name: String = ""
    var countries: [Country] = [Country]()
    var info_complete:Bool = true
    var first_time = true
    
    
    func createInsuraceCompany(name: String){
        
        // Init Insurance Company Name
        self.name = name
    
        // Countries Data
        let country_image_names: [String] = ["USA", "United Kingdom", "France", "Italy", "Sweden", "Japan", "Germany","South Korea"]
        let country_names: [String] = ["أمريكه", "المملكة المتحدة", "فرنسا", "إيطاليا", "السويد", "اليابان", "ألمانيا", "كوريا"]
        
        
        // USA
        let USA_MAN_IMAGE_NAMES = ["buick", "cadillac" , "chevrolet" , "chrysler", "dodge", "ford", "gmc", "hummer", "jeep", "lincoln", "mercury", "oldsmobile", "pontiac", "saturn"]
        let USA_MAN_NAMES = [ "بيويك", "كدلك", "تشيفروليت", "كرايسلر" ,"دودج" ,"فورد", "جيمس", "هامر", "جيب", "لينكولن" ,"ميركوري", "أولدموبيل", "بونتياك", "ساتورن"]
        
        let USA: Country = Country()
        USA.setupCountry(name:country_names[0] , image_name: country_image_names[0], man_names: USA_MAN_NAMES, man_image_names: USA_MAN_IMAGE_NAMES)
        
        self.countries.append(USA)
        
        //UK
        
        let UK_MAN_IMAGE_NAMES = ["aston martin","bentley","jaguar","land rover","lotus","rolls-royce"]
        let UK_MAN_NAMES  = ["أستون مارتن", "بنتلي", "جاكوار", "لاند روفر", "لوتس", "رولزرويس"]
        
        let UK: Country = Country()
        UK.setupCountry(name: country_names[1] , image_name: country_image_names[1], man_names: UK_MAN_NAMES, man_image_names: UK_MAN_IMAGE_NAMES)
 
        self.countries.append(UK)
        
        //France
        
        let FRANCE_MAN_IMAGE_NAMES = ["bugatti", "renault"]
        let FRANCE_MAN_NAMES = ["بوجاتي", "رينو"]
        
        let FRANCE : Country = Country()
        FRANCE.setupCountry(name: country_names[2], image_name: country_image_names[2], man_names: FRANCE_MAN_NAMES, man_image_names: FRANCE_MAN_IMAGE_NAMES)
        
        self.countries.append(FRANCE)
        
        // Italy
        
        let ITALY_MAN_IMAGE_NAMES: [String] = ["alfa romeo", "ferrari", "fiat", "lamborghini", "maserati"]
        let ITALY_MAN_NAMES: [String] = ["ألفا روميو", "فيراري", "فيات", "لامبورغيني", "مازيراتي"]
        
        let ITALY: Country = Country()
        ITALY.setupCountry(name: country_names[3], image_name: country_image_names[3], man_names: ITALY_MAN_NAMES, man_image_names: ITALY_MAN_IMAGE_NAMES)
        
        self.countries.append(ITALY)
        
        // Sweden
        
        let SWEDEN_MAN_IMAGE_NAMES: [String] = ["saab", "volvo"]
        let SWEDEN_MAN_NAMES : [String] = ["ساب" , "فولفو"]
        
        let SWEDEN: Country = Country()
        SWEDEN.setupCountry(name: country_names[4], image_name: country_image_names[4], man_names: SWEDEN_MAN_NAMES, man_image_names: SWEDEN_MAN_IMAGE_NAMES)
        
        self.countries.append(SWEDEN)
        
        
        // Japan
        
        let JAPAN_MAN_IMAGE_NAMES: [String] = ["acura","honda","infiniti","isuzu","lexus","mazda","mitsubishi","nissan","scion","subaru","suzuki","toyota"]
        let JAPAN_MAN_NAMES: [String] = ["أكيورا", "هوندا", "إنفينيتي", "ايسوزو", "لكزس", "مازدا", "ميتسوبيشي", "نيسان", "سيون", "سوبارو", "سوزوكي", "تويوتا"]
        
        let JAPAN: Country = Country()
        JAPAN.setupCountry(name: country_names[5], image_name: country_image_names[5], man_names: JAPAN_MAN_NAMES, man_image_names: JAPAN_MAN_IMAGE_NAMES)
        
        self.countries.append(JAPAN)
        
        
        // Germany
        let GERMANY_MAN_IMAGE_NAMES: [String] = ["audi","bmw","mercedes","maybach","mini","porsche","smart","volkswagen"]
        let GERMANY_MAN_NAMES: [String] = ["أودي", "بيأم", "مرسيدس", "مايباخ", "ميني", "بورش", "سمارت", "فولكس واجن"]
        
        let GERMANY: Country = Country()
        GERMANY.setupCountry(name: country_names[6], image_name: country_image_names[6], man_names: GERMANY_MAN_NAMES, man_image_names: GERMANY_MAN_IMAGE_NAMES)
        
        self.countries.append(GERMANY)
        
        // South Korea 
        let KOREA_MAN_IMAGE_NAMES : [String] = ["hyundai","kia"]
        let KOREA_MAN_NAMES : [String] = ["هيونداي", "كيا"]
        
        let KOREA: Country = Country()
        KOREA.setupCountry(name: country_names[7], image_name: country_image_names[7], man_names: KOREA_MAN_NAMES, man_image_names: KOREA_MAN_IMAGE_NAMES)
        
        self.countries.append(KOREA)
        
        
    }
    
    
    
}
