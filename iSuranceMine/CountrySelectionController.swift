//
//  ViewController.swift
//  iSuranceMine
//
//  Created by Abdullah Al Dhabaib on 5/11/17.
//  Copyright © 2017 Abdullah Al Dhabaib. All rights reserved.
//

import UIKit
import Magnetic
import SpriteKit


class CountrySelectionController: UIViewController {
    
    
    var insuranceCompany: InsuranceCompany = InsuranceCompany()
    var selectedCountry: Country = Country()
    
    var magnetic: Magnetic {
        return magneticView.magnetic
    }
    
    @IBOutlet weak var magneticView: MagneticView! {
        didSet{
            magnetic.magneticDelegate = self
        }
    }
    
    
    func loadUI(){
        
        // Setup
        
        self.view.isUserInteractionEnabled = true
        
        var index = 0
        for _ in 0..<self.insuranceCompany.countries.count {
            if(self.insuranceCompany.countries[index].info_complete != true ){
                let color = UIColor.colors.randomItem()
                let node = Node(text: self.insuranceCompany.countries[index].name, image: UIImage(named: self.insuranceCompany.countries[index].image_name), color: color, radius: 70)
                magnetic.addChild(node)
            
            }
            index = index + 1
        }
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadUI()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismissSelf(_ sender: Any) {
        self.insuranceCompany = InsuranceCompany()
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func unwindToCountrySelection(segue: UIStoryboardSegue) {
        self.loadUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "companySelection"){
            let destinationVC = segue.destination as! CompanySelectionController
            destinationVC.country = self.selectedCountry
            destinationVC.insuranceCompany = self.insuranceCompany
        }
        
    }
    
    
    
}


// MARK: - MagneticDelegate
extension CountrySelectionController: MagneticDelegate {
    
    func magnetic(_ magnetic: Magnetic, didSelect node: Node) {
        
        self.view.isUserInteractionEnabled = false
        
        node.label.isHidden = true
        
        for country in self.insuranceCompany.countries {
            if(country.name == node.label.text){
                self.selectedCountry = country
            }
        }
        
        let when = DispatchTime.now() + 0.5 // change 2 to desired number of seconds
        let after = when + 0.5
        
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.fadeOut()
        }
        
        DispatchQueue.main.asyncAfter(deadline: after) {
            self.performSegue(withIdentifier: "companySelection", sender: nil)
        }
        
        
        print("didSelect -> \(node)")
    }
    
    func fadeOut(){
        let speed = magnetic.physicsWorld.speed
        magnetic.physicsWorld.speed = 0
        let sortedNodes = magnetic.children.flatMap { $0 as? Node }.sorted { node, nextNode in
            let distance = node.position.distance(from: magnetic.magneticField.position)
            let nextDistance = nextNode.position.distance(from: magnetic.magneticField.position)
            return distance < nextDistance && node.isSelected
        }
        var actions = [SKAction]()
        for (index, node) in sortedNodes.enumerated() {
            node.physicsBody = nil
            let action = SKAction.run { [unowned magnetic, unowned node] in
                if node.isSelected {
                    let point = CGPoint(x: magnetic.size.width / 2, y: magnetic.size.height + 40)
                    let movingXAction = SKAction.moveTo(x: point.x, duration: 0.2)
                    let movingYAction = SKAction.moveTo(y: point.y, duration: 0.4)
                    let resize = SKAction.scale(to: 0.3, duration: 0.4)
                    let throwAction = SKAction.group([movingXAction, movingYAction, resize])
                    node.run(throwAction) { [unowned node] in
                        node.removeFromParent()
                    }
                } else {
                    node.removeFromParent()
                }
            }
            actions.append(action)
            let delay = SKAction.wait(forDuration: TimeInterval(index) * 0.002)
            actions.append(delay)
        }
        magnetic.run(.sequence(actions)) { [unowned magnetic] in
            magnetic.physicsWorld.speed = speed
        }
        
    }
    
    
    func magnetic(_ magnetic: Magnetic, didDeselect node: Node) {
        node.label.isHidden = false
        print("didDeselect -> \(node)")
    }
    
}


