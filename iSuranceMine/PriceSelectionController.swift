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


class PriceSelectionController: UIViewController {
    
    var insuranceCompany: InsuranceCompany = InsuranceCompany()
    var country: Country = Country()
    var selected_manafacturers: [Manafacturer] = [Manafacturer]()
    var selected_types: [String] = []
    var selected_year: [String] = []
    var selected_price: [String] = []
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
        self.currentCompanies.text = self.currentCompanies.text! + "]"

        
        
        let names: [String] = self.flowManager.price_remaining
        var counter = 0
        self.totalNodes = 0
        
        for _ in 0..<names.count {
            
            let color = UIColor.colors.randomItem()
            
            switch counter {
            case 0:
                let node = Node(text: names[counter], image: UIImage(named: "blank"), color: UIColor.colors[counter % 2], radius: 70)
                node.label.fontSize = 20
                magnetic.addChild(node)
                break
            case 1:
                let node = Node(text: names[counter], image: UIImage(named: "blank"), color: UIColor.colors[counter % 2], radius: 80)
                node.label.fontSize = 25
                magnetic.addChild(node)
                break
            case 2:
                let node = Node(text: names[counter], image: UIImage(named: "blank"), color: UIColor.colors[counter % 2], radius: 90)
                node.label.fontSize = 30
                magnetic.addChild(node)
                break
            case 3:
                let node = Node(text: names[counter], image: UIImage(named: "blank"), color: UIColor.colors[counter % 2], radius: 100)
                node.label.fontSize = 35
                magnetic.addChild(node)
                break
            case 4:
                let node = Node(text: names[counter], image: UIImage(named: "blank"), color: UIColor.colors[counter % 2], radius: 109)
                node.label.fontSize = 40
                magnetic.addChild(node)
                break
                
            default:
                let node = Node(text: names[counter], image: UIImage(named: "blank"), color: color, radius: 109)
                node.label.fontSize = 40
                magnetic.addChild(node)
                break
            }
            
            
            counter = counter + 1
            self.totalNodes = self.totalNodes + 1
            
        }

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadUI()
        // Testing Magnetc Node
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func goToYearSelection(_ sender: Any) {
            if(self.nodesSelected.count != 0){
        // Add Price To Selection
        for n in self.nodesSelected {
            let price = n.label.text
            self.selected_price.append(price!)
            self.flowManager.price_remaining = self.flowManager.price_remaining.filter{$0 != n.label.text!}

        }

        let when = DispatchTime.now() + 0.5 // change 2 to desired number of seconds
        let after = when + 0.5
        
        DispatchQueue.main.asyncAfter(deadline: when) {
            self.fadeOut()
        }
        
        DispatchQueue.main.asyncAfter(deadline: after) {
            self.performSegue(withIdentifier: "rateForm", sender: nil)
        }
        
        }
    }
    
    @IBAction func goBack(_ sender: Any) {
        self.flowManager.price_remaining = ["2,500KD - 10,000KD"," 10,001KD - 15,000KD"," 15,001KD - 20,000KD"," 20,001KD - 25,000KD","25,001KD وفوق"]
        self.flowManager.year_remaining = ["٥ سنين من عمر الوكاله", "٦ سنين وما فوق"]

         self.performSegue(withIdentifier: "unwindToYearPrice", sender: nil)
    }
    @IBAction func removeNodes(_ sender: Any) {
        for node in self.nodesSelected{
            node.removeFromParent()
            self.flowManager.price_remaining = self.flowManager.price_remaining.filter{$0 != node.label.text!}
        }
        
        
        let count = self.nodesSelected.count
        
        
        if(count == self.totalNodes){
            if(self.flowManager.year_remaining.count > 0) {
                self.flowManager.price_remaining = ["2,500KD - 10,000KD"," 10,001KD - 15,000KD"," 15,001KD - 20,000KD"," 20,001KD - 25,000KD","25,001KD وفوق"]
                self.performSegue(withIdentifier: "unwindToYearPrice", sender: nil)
            }
            else if(self.flowManager.type_remaining.count > 0) {
                self.flowManager.price_remaining = ["2,500KD - 10,000KD"," 10,001KD - 15,000KD"," 15,001KD - 20,000KD"," 20,001KD - 25,000KD","25,001KD وفوق"]
                self.flowManager.year_remaining = ["٥ سنين من عمر الوكاله", "٦ سنين وما فوق"]
                self.performSegue(withIdentifier: "unwindToTypePrice", sender: nil)
            }
            else{
                
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
                    self.performSegue(withIdentifier: "unwindToCompanyPrice", sender: nil)
                }
                else{
                    
                    for state in self.insuranceCompany.countries{
                        if(state == country){
                            state.info_complete = true
                        }
                    }
                    
                    self.performSegue(withIdentifier: "unwindToCountryPrice", sender: nil)
                }
            }
        }
        else{
            self.totalNodes = self.totalNodes - self.nodesSelected.count
        }
        

        self.nodesSelected.removeAll()
       

    }
    
    @IBAction func unwindToPriceSelection(segue: UIStoryboardSegue) {
        
       print("I was unwided")
        
       self.selected_price.removeAll()
       self.nodesSelected.removeAll()
       self.loadUI()

    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "rateForm"){
            let destinationVC = segue.destination as! FormOneViewController
            destinationVC.insuranceCompany = self.insuranceCompany
            destinationVC.country = self.country
            destinationVC.selected_manafacturers = self.selected_manafacturers
            destinationVC.selected_types = self.selected_types
            destinationVC.selected_year = self.selected_year
            destinationVC.selected_price = self.selected_price
            destinationVC.flowManager = self.flowManager
        }
       else if(segue.identifier == "unwindToYearPrice"){
            let destinationVC = segue.destination as! YearSelectionController
            destinationVC.insuranceCompany = self.insuranceCompany
            destinationVC.country = self.country
            destinationVC.selected_manafacturers = self.selected_manafacturers
            destinationVC.selected_types = self.selected_types
            destinationVC.selected_year = []
            destinationVC.flowManager = self.flowManager
        }
        else if(segue.identifier == "unwindToTypePrice"){
            let destinationVC = segue.destination as! TypeSelectionController
            destinationVC.insuranceCompany = self.insuranceCompany
            destinationVC.country = self.country
            destinationVC.selected_manafacturers = self.selected_manafacturers
            destinationVC.selected_types = []
            destinationVC.flowManager = self.flowManager
        }
        else if(segue.identifier == "unwindToCompanyPrice"){
            let destinationVC = segue.destination as! CompanySelectionController
            destinationVC.insuranceCompany = self.insuranceCompany
            destinationVC.country = self.country
        }
        else if(segue.identifier == "unwindToCountryPrice"){
            let destinationVC = segue.destination as! CountrySelectionController
            destinationVC.insuranceCompany = self.insuranceCompany
        }

        
    }
    

    
}


// MARK: - MagneticDelegate
extension PriceSelectionController: MagneticDelegate {
    
    func magnetic(_ magnetic: Magnetic, didSelect node: Node) {
        node.label.fontColor = UIColor.black
        self.nodesSelected.append(node)
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
        node.label.fontColor = UIColor.white
        
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
    
}


