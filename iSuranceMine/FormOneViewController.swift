//
//  FormOneViewController.swift
//  iSuranceMine
//
//  Created by Abdullah Al Dhabaib on 5/21/17.
//  Copyright © 2017 Abdullah Al Dhabaib. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class FormOneViewController: UIViewController, UITextFieldDelegate{

    var insuranceCompany: InsuranceCompany = InsuranceCompany()
    var country: Country = Country()
    var selected_manafacturers: [Manafacturer] = [Manafacturer]()
    var selected_types: [String] = []
    var selected_year: [String] = []
    var selected_price: [String] = []
    var flowManager: DataFlowManager = DataFlowManager()
    
    @IBOutlet weak var currentCompanies: UILabel!
    @IBOutlet weak var fileTextField: SkyFloatingLabelTextField!
    
    
    @IBOutlet weak var usageTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var nonAccidentTextField: SkyFloatingLabelTextField!
    
    @IBOutlet weak var nonAccidentTwoTextField: SkyFloatingLabelTextField!
   
    @IBOutlet weak var nonAccidentThreeTextField: SkyFloatingLabelTextField!
    
    
    
    @IBOutlet weak var windowTextfield: SkyFloatingLabelTextField!
    
    @IBOutlet weak var win_inside: UIButton!
    
    @IBOutlet weak var win_outside: UIButton!
   
    var fileCost =  "N/A"
    var usauge = "N/A"
    var majhool = "N/A"
    var majhool_2 = "N/A"
    var majhool_3 = "NOT USED"
    var fix_inside = "false"
    var fix_outside = "false"
    var windowPercent = "N/A"
    var windowFix_outside = "false"
    var windowFix_inside = "false"
    
    var civilRight = "N/A"
    var returnRight = "N/A"
    
    @IBOutlet weak var inside_button: UIButton!
    @IBOutlet weak var outside_button: UIButton!
    
    var selected = UIImage(named: "button")
    var unselected = UIImage(named: "button_2")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.fileTextField.delegate = self
        self.usageTextField.delegate = self
        self.nonAccidentTextField.delegate = self
        self.nonAccidentTwoTextField.delegate = self
        self.nonAccidentThreeTextField.delegate = self
        self.windowTextfield.delegate = self
        
        
        
        self.fileTextField.becomeFirstResponder()
        
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
         self.currentCompanies.text = self.currentCompanies.text! + "] ← \n ["
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
    
    
    @IBAction func next(_ sender: Any) {
        
        
        self.windowPercent = self.windowTextfield.text!
        
        if(!((fileTextField.text?.isEmpty)!) && !((usageTextField.text?.isEmpty)!) && !((nonAccidentTextField.text?.isEmpty)!) && !((nonAccidentTwoTextField.text?.isEmpty)!) && self.windowPercent != "" &&  !((nonAccidentThreeTextField.text?.isEmpty)!)){
            
            fileCost =  self.fileTextField.text!
            usauge = self.usageTextField.text!
            majhool = nonAccidentTextField.text!
            majhool_2 = nonAccidentTwoTextField.text!
            majhool_3 = nonAccidentThreeTextField.text!
            
            
            if(self.insuranceCompany.first_time){
                 self.performSegue(withIdentifier: "rateForm2", sender: nil)
                 self.insuranceCompany.first_time = false
            }else{
                 self.performSegue(withIdentifier: "skip", sender: nil)
            }
            
           
        }
        
    }
    
    
    @IBAction func outsideSelected(_ sender: Any) {
    
        
        if(self.fix_outside == "false" || self.fix_outside == "N/A"){
            self.outside_button.setBackgroundImage(selected, for: UIControlState.normal)
            self.outside_button.setTitleColor(UIColor.white, for: UIControlState.normal)
            self.fix_outside = "true"
        }
        else{
            self.outside_button.setBackgroundImage(unselected, for: UIControlState.normal)
            self.outside_button.setTitleColor(UIColor.blue, for: UIControlState.normal)
            self.fix_outside = "false"
        }
        
    }
    
    
    @IBAction func insideSelected(_ sender: Any) {
        
        if(self.fix_inside == "false" || self.fix_inside == "N/A"){
            self.inside_button.setBackgroundImage(selected, for: UIControlState.normal)
            self.inside_button.setTitleColor(UIColor.white, for: UIControlState.normal)
            self.fix_inside = "true"
        }
        else{
            self.inside_button.setBackgroundImage(unselected, for: UIControlState.normal)
            self.inside_button.setTitleColor(UIColor.blue, for: UIControlState.normal)
            self.fix_inside = "false"
        }

        
    }
    
    
    @IBAction func inside_selected(_ sender: Any) {
        if(self.windowFix_inside == "false" || self.windowFix_inside == "N/A"){
            self.win_inside.setBackgroundImage(selected, for: UIControlState.normal)
            self.win_inside.setTitleColor(UIColor.white, for: UIControlState.normal)
            self.windowFix_inside = "true"
        }
        else{
            self.win_inside.setBackgroundImage(unselected, for: UIControlState.normal)
            self.win_inside.setTitleColor(UIColor.blue, for: UIControlState.normal)
            self.windowFix_inside = "false"
        }

    }
    
    
    @IBAction func outside_selected(_ sender: Any) {
        if(self.windowFix_outside == "false" || self.windowFix_outside == "N/A"){
            self.win_outside.setBackgroundImage(selected, for: UIControlState.normal)
            self.win_outside.setTitleColor(UIColor.white, for: UIControlState.normal)
            self.windowFix_outside = "true"
        }
        else{
            self.win_outside.setBackgroundImage(unselected, for: UIControlState.normal)
            self.win_outside.setTitleColor(UIColor.blue, for: UIControlState.normal)
            self.windowFix_outside = "false"
        }

    }
    
  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

        if(segue.identifier == "rateForm2"){
            let destinationVC = segue.destination as! FormTwoViewController
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

            
        }
        else if(segue.identifier == "skip"){
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
            destinationVC.roadsideCost = "skip"
            destinationVC.day0_1_price = "skip"
            destinationVC.day0_2_price = "skip"
            destinationVC.day0_3_price = "skip"
            destinationVC.day1_1_price = "skip"
            destinationVC.day1_2_price = "skip"
            destinationVC.day1_3_price = "skip"
            destinationVC.day2_1_price = "skip"
            destinationVC.day2_2_price = "skip"
            destinationVC.day2_3_price = "skip"
            destinationVC.civilRight =   "skip"
            destinationVC.returnRight = "skip"
            
            
        }
    
        
    }
 

}
