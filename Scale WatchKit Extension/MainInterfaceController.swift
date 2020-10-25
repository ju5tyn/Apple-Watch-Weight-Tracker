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
    
    
    var currentWeight: Double?
    
    
    private func authorizeHealthKit() {
        HealthKitSetupAssistant.authorizeHealthKit { (authorised, error) in
            guard authorised else{
                
                let baseMessage = "HealthKit auth failed"
                
                if let error = error {
                    print(error.localizedDescription)
                } else{
                    print(baseMessage)
                }
                
                return
            }
            print("healthkit authorised")
        }
    }
    
    
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        
        
        //workaround to set corner radius
        updateWeightButtonGroup.setCornerRadius(25)
        
        authorizeHealthKit()
        
        currentWeight = 0
        
        loadBodyMass()
        updateUI()
        
        crownSequencer.delegate = self
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        authorizeHealthKit()
        loadBodyMass()
        updateUI()
        
        crownSequencer.focus()
        
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    func crownDidRotate(_ crownSequencer: WKCrownSequencer?, rotationalDelta: Double) {
        
        let newValue = currentWeight! + (2*Double(rotationalDelta))
        setWeight(value: newValue)
    }
    
    @IBAction func weightSliderPressed(_ value: Float) {
        
        setWeight(value: Double(value))
        
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
        //weightSlider.setValue(Float(currentWeight!))
        
    }
    
    @IBAction func updateWeightButtonPressed() {
        
        
        
    }
    
    func loadBodyMass() {
        
        guard let bodyMassSampleType = HKSampleType.quantityType(forIdentifier: .height) else{
            print("sample type no longer available")
            return
        }
        
        ProfileDataStore.getCurrentBodyMass(for: bodyMassSampleType) { (sample, error) in
            
            guard let sample = sample else {
                
                if let error = error{
                    print(error)
                }
                
                return
                
            }
            
            self.currentWeight = sample.quantity.doubleValue(for: HKUnit.gram())/1000
            //print(self.currentWeight)
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
}
