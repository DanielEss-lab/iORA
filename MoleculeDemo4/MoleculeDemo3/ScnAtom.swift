//
//  Atom.swift
//  MoleculeDemo3
//
//  Created by Gabriel Reed on 8/25/20.
//  Copyright © 2020 Gabriel Reed. All rights reserved.
//

import Foundation
import SceneKit

struct SCNAtom {
    var name: String
    var x: Double
    var y: Double
    var z: Double
    var radius: Double
    var positions: [SCNVector3]
    var actions: [SCNAction]
    var bondedTo: [SCNNode] // FIXME: Could this just be an int? 
    var bondNum: Int {
        return maxBonds[name] ?? 1
    }
}
