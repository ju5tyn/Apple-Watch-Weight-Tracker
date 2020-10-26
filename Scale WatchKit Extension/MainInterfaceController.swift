//
//  InterfaceController.swift
//  Scale WatchKit Extension
//
//  Created by Justyn Henman on 28/09/2020.
//  Copyright © 2020 Justyn Henman. All rights reserved.
//

import WatchKit
import Foundation
import HealthKit


class MainInterfaceController: WKInterfaceController, WKCrownDelegate {

    @IBOutlet weak var kilogramLabel: WKInterfaceLabel!
    @IBOutlet weak var updateWeightButton: WKInterfaceButton!
    @IBOutlet weak var updateWeightButtonGroup: WKInterfaceGroup!
    
    
    var currentWeight: Double? = 0.0
    
    
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        //workaround to set corner radius
        updateWeightButtonGroup.setCornerRadius(25)
        
        crownSequencer.delegate = self
    
    
    }
    
    override func willActivate() {
        super.willActivate()
        
        crownSequencer.focus()
        
    }
    
    override func didDeactivate() {
        super.didDeactivate()
        
    }
    
    @IBAction func updateWeightButtonPressed() {
        
        
    }

    
    @IBAction func pullHKButtonPressed() {
        
        
    }
    
    
    @IBAction func displayHKButtonPressed() {
        
        
    }
    
    
    func crownDidRotate(_ crownSequencer: WKCrownSequencer?, rotationalDelta: Double) {
        
        let newValue = currentWeight! + (2*Double(rotationalDelta))
        setWeight(value: newValue)
        
    }
    
    func setWeight(value: Double){
        
        if value < 1 {
            currentWeight = 1
        } else if value > 100 {
            currentWeight = 100
        } else {
            currentWeight = Double(value)
        }
        
        updateUI()
        
    }
    
    func updateUI(){
        
        let weightLabelText = String(round(currentWeight!*10)/10)
        kilogramLabel.setText("\(weightLabelText)")
        
    }

    
    
}
