//
//  ConfirmationInterfaceController.swift
//  Scale WatchKit Extension
//
//  Created by Justyn Henman on 28/09/2020.
//  Copyright © 2020 Justyn Henman. All rights reserved.
//

import Foundation
import WatchKit

class ConfirmationInterfaceController: WKInterfaceController {

    @IBOutlet weak var buttonGroup: WKInterfaceGroup!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        //workaround to set corner radius of buttons
        buttonGroup.setCornerRadius(25)
    }
    
    
    @IBAction func okButtonPressed() {
        popToRootController()
    }
    
    
}
