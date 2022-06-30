//
//  Defaults.swift
//  iORA
//
//  Created by Jeremiah on 6/27/22.
//

import Foundation
import UIKit

class Defaults {
    let defaults = UserDefaults.standard
    
    func setUp()
    {
        if defaults.bool(forKey: "SET_UP_PERFORMED") == false
        {
            defaults.set(0.1, forKey: "STEP_DURATION")
            //defaults.set(1.0, forKey: "DISTANCE_MULTIPLIER")
            defaults.set(1.0, forKey: "SCALE_FACTOR")
            defaults.set(0.6, forKey: "BOND_RADIUS")
            defaults.set(0.4, forKey: "PARTIAL_BOND_RADIUS")
            defaults.set(false, forKey: "COLORED_BONDS")
            
            //..
            defaults.set(true, forKey: "SET_UP_PERFORMED")
        }
    }
}

