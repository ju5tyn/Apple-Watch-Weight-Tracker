//
//  InterfaceController.swift
//  Scale WatchKit Extension
//
//  Created by Justyn Henman on 28/09/2020.
//  Copyright © 2020 Justyn Henman. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController, WKCrownDelegate {

    @IBOutlet weak var kilogramLabel: WKInterfaceLabel!
    @IBOutlet weak var updateWeightButton: WKInterfaceButton!
    @IBOutlet weak var weightSlider: WKInterfaceSlider!
    
    
    var currentWeight: Double?
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        currentWeight = 75.5
        weightSlider.setValue(Float(currentWeight!))
        kilogramLabel.setText("\(currentWeight!)kg")
        
        crownSequencer.delegate = self
        crownSequencer.focus()
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    func crownDidRotate(_ crownSequencer: WKCrownSequencer?, rotationalDelta: Double) {
        
        let newValue = currentWeight! + Double(rotationalDelta)
        if newValue < 1 {
            currentWeight = 1
        } else if newValue > 100 {
            currentWeight = 100
        } else {
            currentWeight = newValue
        }
        
        let weightLabelText = String(round(currentWeight!*10)/10)
        //currentWeight = currentWeight?.rounded()
        kilogramLabel.setText("\(weightLabelText)kg")
        weightSlider.setValue(Float(currentWeight!))
    }
    
    @IBAction func updateWeightButtonPressed() {
        
        
        
    }
    
    @IBAction func weightSliderPressed(_ value: Float) {
        
        
        
        //let newValue = currentWeight! + Double(value)
        print(Double(value))
        if value < 1 {
            currentWeight = 1
        } else if value > 100 {
            currentWeight = 100
        } else {
            currentWeight = Double(value)
        }
        let weightLabelText = String(round(currentWeight!*10)/10)
        //currentWeight = currentWeight?.rounded()
        kilogramLabel.setText("\(weightLabelText)kg")
        weightSlider.setValue(Float(currentWeight!))
    }
    
    
}
