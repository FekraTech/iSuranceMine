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


class TypeSelectionController: UIViewController {
    
    
    var insuranceCompany: InsuranceCompany = InsuranceCompany()
    var country: Country = Country()
    var selected_manafacturers: [Manafacturer] = [Manafacturer]()
    var selected_types: [String] = []
    var flowManager: DataFlowManager = DataFlowManager()
    var totalNodes = 0

    @IBOutlet weak var currentCompanies: UILabel!
    
    
    var nodesSelected = [Node]()
    
    var magnetic: Magnetic {
        return magneticView.magnetic
    }
    
    @IBOutlet weak var magneticView: MagneticView! {
        didSet{
            magnetic.magneticDelegate = self
        }
    }
    
    
    func loadUI(){
        // Insure both types exist
        self.currentCompanies.text = "["
        for m in self.selected_manafacturers{
            self.currentCompanies.text = self.currentCompanies.text! + " " + m.name
        }
        self.currentCompanies.text = self.currentCompanies.text! + "]"
        
        let image_names: [String] = ["sport", "non-sport"]
        let names: [String] = flowManager.type_remaining
        let colors: [UIColor] = [UIColor.tealBlue, UIColor.blue]
        var counter = 0
        self.totalNodes = 0
        
        for _ in 0..<flowManager.type_remaining.count {
            
            let color = colors[counter]
            let node = Node(text: names[counter], image: UIImage(named: image_names[counter]), color: color, radius: 70)
            node.label.fontSize = 30
            magnetic.addChild(node)
            counter = counter + 1
            self.totalNodes = self.totalNodes + 1
            
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
    @IBAction func goToYearSelection(_ sender: Any) {
        
            if(self.nodesSelected.count != 0){
        
        // Add Type To Selection
        for n in self.nodesSelected {
            let type = n.label.text
            self.selected_types.append(type!)
            
        }
        
        // Update Flow Manager
        for type in self.selected_types {
            self.flowManager.type_remaining =  self.flowManager.type_remaining.filter{$0 != type}
        }
        
        
        let when = DispatchTime.now() + 0.5 // change 2 to desired number of seconds
        let after = when + 0.5
        
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.fadeOut()
        }
        
        DispatchQueue.main.asyncAfter(deadline: after) {
            self.performSegue(withIdentifier: "yearSelection", sender: nil)
        }
        }
        
    }
    
    @IBAction func removeNodes(_ sender: Any) {
        for node in self.nodesSelected{
            self.flowManager.type_remaining =  self.flowManager.type_remaining.filter{$0 != node.label.text!}
            node.removeFromParent()
        }
        
        let count = self.nodesSelected.count
        
        
        if(count == self.totalNodes){
            
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
                self.performSegue(withIdentifier: "unwindToCompanyType", sender: nil)
            }
            else{
                
                for state in self.insuranceCompany.countries{
                    if(state == country){
                        state.info_complete = true
                    }
                }
                
                self.performSegue(withIdentifier: "unwindToCountryType", sender: nil)
            }
        }
        else{
            self.totalNodes = self.totalNodes - self.nodesSelected.count
        }
        
        self.nodesSelected.removeAll()
        
    }
    
    
    @IBAction func unwindToTypeSelection(segue: UIStoryboardSegue) {
        self.selected_types.removeAll()
        self.nodesSelected.removeAll()
        self.loadUI()
    }
    @IBAction func goBack(_ sender: Any) {
        self.flowManager.price_remaining = ["2,500KD - 10,000KD"," 10,001KD - 15,000KD"," 15,001KD - 20,000KD"," 20,001KD - 25,000KD","25,001KD وفوق"]
        self.flowManager.year_remaining = ["٥ سنين من عمر الوكاله", "٦ سنين وما فوق"]
        self.flowManager.type_remaining =   ["سبورت", "ليس سبورت"]
        
      
        self.performSegue(withIdentifier: "unwindToCompanyType", sender: nil)

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "yearSelection"){
            
            let destinationVC = segue.destination as! YearSelectionController
            destinationVC.insuranceCompany = self.insuranceCompany
            destinationVC.country = self.country
            destinationVC.selected_manafacturers = self.selected_manafacturers
            destinationVC.selected_types = self.selected_types
            destinationVC.flowManager = self.flowManager
        }
        
        else if(segue.identifier == "unwindToCompanyType"){
            let destinationVC = segue.destination as! CompanySelectionController
            destinationVC.insuranceCompany = self.insuranceCompany
            destinationVC.country = self.country
        }
        else if(segue.identifier == "unwindToCountryType"){
            let destinationVC = segue.destination as! CountrySelectionController
            destinationVC.insuranceCompany = self.insuranceCompany
        }

        
    }
    
    
    
}


// MARK: - MagneticDelegate
extension TypeSelectionController: MagneticDelegate {
    
    func magnetic(_ magnetic: Magnetic, didSelect node: Node) {
        node.label.isHidden = true
        self.nodesSelected.append(node)
        
        print("didSelect -> \(node)")
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
        
        
        print("didDeselect -> \(node)")
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
    
    
}


