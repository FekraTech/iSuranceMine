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


class  CompanySelectionController: UIViewController {
    
    var insuranceCompany: InsuranceCompany = InsuranceCompany()
    var country: Country = Country()
    var selected_manafacturers: [Manafacturer] = [Manafacturer]()
    var totalNodes = 0
    
    var nodesSelected = [Node]()
    
    var magnetic: Magnetic {
        return magneticView.magnetic
    }
    @IBOutlet weak var header: UILabel!
    
    @IBOutlet weak var magneticView: MagneticView! {
        didSet{
            magnetic.magneticDelegate = self
        }
    }
    
    
    func loadUI(){
        
        // Setup
        
        self.header.text = "الشركات" + " " +  self.country.name
        
        var counter = 0
        self.totalNodes = 0
        
        for _ in 0..<self.country.manafacturers.count {
            
            if(self.country.manafacturers[counter].info_complete != true){
                
                let color = UIColor.colors.randomItem()
                let node = Node(text: self.country.manafacturers[counter].name, image: UIImage(named: self.country.manafacturers[counter].image_name), color: color, radius: 70)
                magnetic.addChild(node)
                self.totalNodes = self.totalNodes + 1
                
            }
            counter = counter + 1
            
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
    
    @IBAction func goToTypeSelection(_ sender: Any) {
        
        
        if(self.nodesSelected.count != 0){
            
            let when = DispatchTime.now() + 0.5 // change 2 to desired number of seconds
            let after = when + 0.5
            
            DispatchQueue.main.asyncAfter(deadline: when) {
                self.fadeOut()
            }
            
            DispatchQueue.main.asyncAfter(deadline: after) {
                self.performSegue(withIdentifier: "typeSelection", sender: nil)
            }
            
        }
        
    }
    
    @IBAction func removeNodes(_ sender: Any) {
        for node in self.nodesSelected{
            node.removeFromParent()
        }
        
        var unwind = false
        
        
        
        if(self.selected_manafacturers.count == self.totalNodes){
            unwind = true
            self.country.info_complete = true
        }
        else{
            self.totalNodes = self.totalNodes - self.nodesSelected.count
        }
        
        
        // Update Country Company
        var index = 0
        for make in self.country.manafacturers{
            
            for selected_make in self.selected_manafacturers{
                
                if(make.name == selected_make.name){
                    self.country.manafacturers.remove(at: index)
                    index = index - 1
                }
            }
            
            index = index + 1
        }
        
        
        
        
        // Update Insurance Company
        index = 0
        for country in self.insuranceCompany.countries {
            if(country.name == self.country.name){
                self.insuranceCompany.countries[index] = self.country
                index = index + 1
            }
            else{
                index = index + 1
                
            }
        }
        
        self.nodesSelected.removeAll()
        self.selected_manafacturers.removeAll()
        
        
        if(unwind == true){
            self.performSegue(withIdentifier: "unwindToCountryBack", sender: nil)
        }
    }
    
    @IBAction func unwindToCompanySelection(segue: UIStoryboardSegue) {
        self.nodesSelected.removeAll()
        self.selected_manafacturers.removeAll()
        self.loadUI()
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.performSegue(withIdentifier: "unwindToCountryBack", sender: nil)

    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "typeSelection"){
            
            
            let destinationVC = segue.destination as! TypeSelectionController
            destinationVC.insuranceCompany = self.insuranceCompany
            destinationVC.country = self.country
            destinationVC.selected_manafacturers = self.selected_manafacturers
        }
            
        else if(segue.identifier == "unwindToCountryBack"){
            let destinationVC = segue.destination as! CountrySelectionController
            destinationVC.insuranceCompany = self.insuranceCompany
        }
        
        
    }
    
    
    
    
    
}


// MARK: - MagneticDelegate
extension CompanySelectionController: MagneticDelegate {
    
    func magnetic(_ magnetic: Magnetic, didSelect node: Node) {
        node.label.isHidden = true
        print("didSelect -> \(node)")
        
        self.nodesSelected.append(node)
        
        // Add Manafactuer to selection
        for company in self.country.manafacturers {
            if(node.label.text == company.name){
                self.selected_manafacturers.append(company)
            }
        }
        
        
        
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
        
        var index = 0
        
        for n in self.nodesSelected{
            if(n.isEqual(to: node)){
                self.nodesSelected.remove(at: index)
            }
            else{
                index = index + 1
            }
        }
        
        
        index = 0
        for company in self.selected_manafacturers {
            if(node.label.text == company.name){
                self.selected_manafacturers.remove(at: index)
            }
            else{
                index = index + 1
            }
            
        }
        
        
        
        
        print("didDeselect -> \(node)")
    }
    
    
    
    
    
}


