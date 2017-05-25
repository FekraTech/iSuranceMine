//
//  RateViewController.swift
//  iSuranceMine
//
//  Created by Abdullah Al Dhabaib on 5/15/17.
//  Copyright © 2017 Abdullah Al Dhabaib. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class RateViewController: UIViewController, UITextFieldDelegate {
    
    var insuranceCompany: InsuranceCompany = InsuranceCompany()
    var country: Country = Country()
    var selected_manafacturers: [Manafacturer] = [Manafacturer]()
    var selected_types: [String] = []
    var selected_year: [String] = []
    var selected_price: [String] = []
    var flowManager: DataFlowManager = DataFlowManager()
    
    @IBOutlet weak var currentCompanies: UILabel!
    var fileCost =  "N/A"
    var usauge = "N/A"
    var majhool = "N/A"
    var majhool_2 = "N/A"
    var majhool_3 = "N/A"
    var fix_inside = "N/A"
    var fix_outside = "N/A"
    var windowPercent = "N/A"
    var windowFix_outside = "false"
    var windowFix_inside = "false"
    var roadsideCost = "N/A"
    
    var civilRight = "N/A"
    var returnRight = "N/A"
    
    
    var carLoanCost = "N/A"
    var carLoanDuration = "N/A"
        
  
    
    var day0_1_price = "0"
    var day0_2_price = "0"
    var day0_3_price = "0"
    
    var day1_1_price = "0"
    var day1_2_price = "0"
    var day1_3_price = "0"
    
    var day2_1_price = "0"
    var day2_2_price = "0"
    var day2_3_price = "0"
    
    @IBOutlet weak var textfield: SkyFloatingLabelTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textfield.delegate = self
        self.textfield.becomeFirstResponder()
        
        
        self.currentCompanies.text = "["
        for m in self.selected_manafacturers{
            self.currentCompanies.text = self.currentCompanies.text! + " " + m.name
        }
        self.currentCompanies.text = self.currentCompanies.text! + "] ← ["
        for t in self.selected_types {
            self.currentCompanies.text = self.currentCompanies.text! + " " + t
        }
        self.currentCompanies.text = self.currentCompanies.text! + "] ← ["
        for y in self.selected_year {
            self.currentCompanies.text = self.currentCompanies.text! + " " + y
            
        }
        self.currentCompanies.text = self.currentCompanies.text! + "] ← \n["
        for p in self.selected_price{
            self.currentCompanies.text = self.currentCompanies.text! + " " + p
        }
        
        self.currentCompanies.text = self.currentCompanies.text! + "]"
        NotificationCenter.default.addObserver(self, selector: #selector(self.flowControl), name: Notification.Name("Uploaded"), object: nil)
        

        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func uploadToDatabase(_ sender: Any) {
        
        if(self.textfield.text?.isEmpty != true){
            
            for make in self.selected_manafacturers{
                
                for type in self.selected_types{
                    
                    for year in self.selected_year{
                        
                        for price in self.selected_price{
                            let classification:CarClassification = CarClassification()
                            classification.insurance_company = self.insuranceCompany.name
                            classification.make = make.name
                            classification.type = type
                            classification.year = year
                            classification.price_range = price
                            classification.rate = self.textfield.text!
                            classification.fileCost = self.fileCost
                            classification.usauge = self.usauge
                            classification.majhool = self.majhool
                            classification.majhool_2 = self.majhool_2
                            classification.majhool_3 = self.majhool_3
                            classification.fix_inside = self.fix_inside
                            classification.fix_outside = self.fix_outside
                            classification.windowPercent = self.windowPercent
                            classification.windowFix_inside = self.windowFix_inside
                            classification.windowFix_outside = self.windowFix_outside
                            classification.roadsideCost = self.roadsideCost
                            classification.day0_1_price = self.day0_1_price
                            classification.day0_2_price = self.day0_2_price
                            classification.day0_3_price = self.day0_3_price
                            classification.day1_1_price = self.day1_1_price
                            classification.day1_2_price = self.day1_2_price
                            classification.day1_3_price = self.day1_3_price
                            classification.day2_1_price = self.day2_1_price
                            classification.day2_2_price = self.day2_2_price
                            classification.day2_3_price = self.day2_3_price
                            classification.civilRight =  self.civilRight
                            classification.returnRight = self.returnRight
                            classification.uploadToDatabase()
                        }
                    }
                    
                }
                
            }
            
        }
       
        
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        print("$CreateAccountController: TEXTFIELD DELEGATE: SHOULD RETURN (\(textField.tag) ")
        
        
        self.uploadToDatabase(self)
        
        return false
        
    }

  
    // Flow Control Using FlowControlManager
    func flowControl(){
        
        // (A) Not All Existing Prices Completed
        if(self.flowManager.price_remaining.count > 0){
            self.performSegue(withIdentifier: "unwindToPriceSelection", sender: nil)
        }
        
        else if(self.flowManager.year_remaining.count > 0) {
            self.flowManager.price_remaining = ["2,500KD - 10,000KD"," 10,001KD - 15,000KD"," 15,001KD - 20,000KD"," 20,001KD - 25,000KD","25,001KD وفوق"]
            self.performSegue(withIdentifier: "unwindToYearSelection", sender: nil)
        }
        else if(self.flowManager.type_remaining.count > 0) {
            self.flowManager.price_remaining = ["2,500KD - 10,000KD"," 10,001KD - 15,000KD"," 15,001KD - 20,000KD"," 20,001KD - 25,000KD","25,001KD وفوق"]
            self.flowManager.year_remaining = ["٥ سنين من عمر الوكاله", "٦ سنين وما فوق"]
            self.performSegue(withIdentifier: "unwindToTypeSelection", sender: nil)
        }
        else {
            
            
            for state in self.insuranceCompany.countries {
                if(state == self.country){
                    for make in state.manafacturers {
                        for selected_make in selected_manafacturers{
                            if(make == selected_make){
                                make.info_complete = true
                                selected_make.info_complete = true
                            }
                        }
                    }
                    
                }
            }
            
            var make_not_complete = false
            
            for state in self.insuranceCompany.countries{
                if(state == self.country){
                    for make in state.manafacturers{
                        if(make.info_complete == false){
                            make_not_complete = true
                        }
                    }
                }
            }
            
            
            if(make_not_complete == true){
                self.performSegue(withIdentifier: "unwindToCompanySelection", sender: nil)
            }
            else{
            
                for state in self.insuranceCompany.countries{
                    if(state == country){
                        state.info_complete = true
                    }
                }
                
                self.performSegue(withIdentifier: "unwindToCountrySelection", sender: nil)
            }
            
            
            
        }
        
        
        
    }
    
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "unwindToYearSelection"){
            let destinationVC = segue.destination as! YearSelectionController
            destinationVC.insuranceCompany = self.insuranceCompany
            destinationVC.country = self.country
            destinationVC.selected_manafacturers = self.selected_manafacturers
            destinationVC.selected_types = self.selected_types
            destinationVC.selected_year = []
            destinationVC.flowManager = self.flowManager
        }
        else if(segue.identifier == "unwindToTypeSelection"){
            let destinationVC = segue.destination as! TypeSelectionController
            destinationVC.insuranceCompany = self.insuranceCompany
            destinationVC.country = self.country
            destinationVC.selected_manafacturers = self.selected_manafacturers
            destinationVC.selected_types = []
            destinationVC.flowManager = self.flowManager
        }
        else if(segue.identifier == "unwindToPriceSelection"){
            let destinationVC = segue.destination as! PriceSelectionController
            destinationVC.insuranceCompany = self.insuranceCompany
            destinationVC.country = self.country
            destinationVC.selected_manafacturers = self.selected_manafacturers
            destinationVC.selected_types = self.selected_types
            destinationVC.selected_year = self.selected_year
            destinationVC.selected_price = []
            destinationVC.flowManager = self.flowManager
        }
        else if(segue.identifier == "unwindToCompanySelection"){
            let destinationVC = segue.destination as! CompanySelectionController
            destinationVC.insuranceCompany = self.insuranceCompany
            destinationVC.country = self.country
        }
        else if(segue.identifier == "unwindToCountrySelection"){
            let destinationVC = segue.destination as! CountrySelectionController
            destinationVC.insuranceCompany = self.insuranceCompany
        }
        
        
    }
    
    
    
    
}
