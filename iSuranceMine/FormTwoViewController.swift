//
//  FormOneViewController.swift
//  iSuranceMine
//
//  Created by Abdullah Al Dhabaib on 5/21/17.
//  Copyright © 2017 Abdullah Al Dhabaib. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class FormTwoViewController: UIViewController, UITextFieldDelegate{
    
    var insuranceCompany: InsuranceCompany = InsuranceCompany()
    var country: Country = Country()
    var selected_manafacturers: [Manafacturer] = [Manafacturer]()
    var selected_types: [String] = []
    var selected_year: [String] = []
    var selected_price: [String] = []
    var flowManager: DataFlowManager = DataFlowManager()
    
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
    
    
    @IBOutlet weak var roadsideTextfield: SkyFloatingLabelTextField!
    
    @IBOutlet weak var civilRightTextField: SkyFloatingLabelTextField!

    @IBOutlet weak var returnTextfield: SkyFloatingLabelTextField!
    @IBOutlet weak var currentCompanies: UILabel!
    
    @IBOutlet weak var day0_1: SkyFloatingLabelTextField!
    @IBOutlet weak var day0_3: SkyFloatingLabelTextField!
    @IBOutlet weak var day0_2: SkyFloatingLabelTextField!
    @IBOutlet weak var day1_1: SkyFloatingLabelTextField!
    @IBOutlet weak var day1_2: SkyFloatingLabelTextField!
    @IBOutlet weak var day1_3: SkyFloatingLabelTextField!
    @IBOutlet weak var day2_1: SkyFloatingLabelTextField!
    @IBOutlet weak var day2_2: SkyFloatingLabelTextField!
    @IBOutlet weak var day2_3: SkyFloatingLabelTextField!
    

    var roadsideCost = "N/A"
    var civilRight = "N/A"
    var returnRight = "N/A"

    var day0_1_price = "0"
    var day0_2_price = "0"
    var day0_3_price = "0"
    
    var day1_1_price = "0"
    var day1_2_price = "0"
    var day1_3_price = "0"
    
    var day2_1_price = "0"
    var day2_2_price = "0"
    var day2_3_price = "0"
    

    var selected = UIImage(named: "button")
    var unselected = UIImage(named: "button_2")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        self.roadsideTextfield.delegate = self
        self.civilRightTextField.delegate = self
        self.returnTextfield.delegate = self
        self.day0_1.delegate = self
        self.day0_2.delegate = self
        self.day0_3.delegate = self
        self.day1_1.delegate = self
        self.day1_2.delegate = self
        self.day1_3.delegate = self
        self.day2_1.delegate = self
        self.day2_2.delegate = self
        self.day2_3.delegate = self

        self.civilRightTextField.becomeFirstResponder()
        
        
        
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
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func next(_ sender: Any) {
        

        self.roadsideCost = self.roadsideTextfield.text!
        self.day0_1_price = self.day0_1.text!
        self.day0_2_price = self.day0_2.text!
        self.day0_3_price = self.day0_3.text!
        self.day1_1_price = self.day1_1.text!
        self.day1_2_price = self.day1_2.text!
        self.day1_3_price = self.day1_3.text!
        self.day2_1_price = self.day2_1.text!
        self.day2_2_price = self.day2_2.text!
        self.day2_3_price = self.day2_3.text!
        self.civilRight = self.civilRightTextField.text!
        self.returnRight = self.returnTextfield.text!
        
        if(roadsideCost != "" ){
            
            self.performSegue(withIdentifier: "final", sender: nil)
            
        }
        
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        print("$CreateAccountController: TEXTFIELD DELEGATE: SHOULD RETURN (\(textField.tag) ")
        // Try to find next responder
        if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextField.becomeFirstResponder()
        } else {
            // Not found, so remove keyboard.
            textField.resignFirstResponder()
        }
        // Do not add a line break
        return false
        
    }


    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "final"){
            let destinationVC = segue.destination as! RateViewController
            destinationVC.insuranceCompany = self.insuranceCompany
            destinationVC.country = self.country
            destinationVC.selected_manafacturers = self.selected_manafacturers
            destinationVC.selected_types = self.selected_types
            destinationVC.selected_year = self.selected_year
            destinationVC.selected_price = self.selected_price
            destinationVC.flowManager = self.flowManager
            destinationVC.fileCost = self.fileCost
            destinationVC.usauge = self.usauge
            destinationVC.majhool = self.majhool
            destinationVC.majhool_2 = self.majhool_2
            destinationVC.majhool_3 = self.majhool_3
            destinationVC.fix_inside = self.fix_inside
            destinationVC.fix_outside = self.fix_outside
            destinationVC.windowPercent = self.windowPercent
            destinationVC.windowFix_inside = self.windowFix_inside
            destinationVC.windowFix_outside = self.windowFix_outside
            destinationVC.roadsideCost = self.roadsideCost
            destinationVC.day0_1_price = self.day0_1_price
            destinationVC.day0_2_price = self.day0_2_price
            destinationVC.day0_3_price = self.day0_3_price
            destinationVC.day1_1_price = self.day1_1_price
            destinationVC.day1_2_price = self.day1_2_price
            destinationVC.day1_3_price = self.day1_3_price
            destinationVC.day2_1_price = self.day2_1_price
            destinationVC.day2_2_price = self.day2_2_price
            destinationVC.day2_3_price = self.day2_3_price
            destinationVC.civilRight =  self.civilRight
            destinationVC.returnRight = self.returnRight
         
            
        }
     }
    
    
}
