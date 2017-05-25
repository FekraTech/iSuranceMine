//
//  InsuranceViewController.swift
//  iSuranceMine
//
//  Created by Abdullah Al Dhabaib on 5/15/17.
//  Copyright © 2017 Abdullah Al Dhabaib. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class InsuranceViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textfield: SkyFloatingLabelTextField!
    var insuranceCompany: InsuranceCompany = InsuranceCompany()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.textfield.delegate = self
        self.textfield.becomeFirstResponder()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func registerInsurance(_ sender: Any) {
        
        if(self.textfield.text?.isEmpty != true){
            self.insuranceCompany = InsuranceCompany()
            self.insuranceCompany.createInsuraceCompany(name: self.textfield.text!)
            self.performSegue(withIdentifier: "countrySelection", sender: nil)
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "countrySelection"){
            let destinationVC = segue.destination as! CountrySelectionController
            destinationVC.insuranceCompany = self.insuranceCompany
        }
        
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {   //delegate method
        print("$CreateAccountController: TEXTFIELD DELEGATE: SHOULD RETURN (\(textField.tag) ")
    
        
        self.registerInsurance(self)
        
        return false
        
    }

    

}
