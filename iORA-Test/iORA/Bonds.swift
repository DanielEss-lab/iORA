//
//  Bonds.swift
//  iORA
//
//  Created by Gabriel Reed on 1/6/21.
//

import Foundation
import SceneKit

/*
 makeBonds algorithm
 for atom1 in atoms:
    for atom2 in atoms:
        calculateDistance
        if distance < 0.8:
            add to dictionary
    sort dictionary
    for i in atom1.getMaxBonds:
        bond atom1 to atom2
 */

/*
 Sort the atoms by number of bonds it can make
    // Could I do something wack like temporarily put the number within the name of the atom, sort them based on that, then strip the number out?
 Start with the smallest ones and make bonds
 Keep track of how many bonds each atom has made, don't let it go over that number
 
 */

func makeBonds() {
    // Full bonds
    for atom1 in atoms {
        var dict: [Double: SCNNode] = [:]
        for atom2 in atoms {
            let radius1 = Float(atomRadii[atom1.name!]?.covalentRadius ?? 0.0)
            let radius2 = Float(atomRadii[atom2.name!]?.covalentRadius ?? 0.0)
            let distance = (calculateDistance(node1: atom1, node2: atom2) - radius1 - radius2)
            
            if distance < 0.8 && atom1 != atom2 && atom2.name != "H" { // FIXME: There may be a problem with negative distance measurements
                dict[Double(distance)] = atom2
            }
        }
        let sortedKeys = Array(dict.keys.sorted(by: <))
        
        for i in 0...(maxBonds[atom1.name ?? "He"] ?? 0) {
            if i < sortedKeys.count {
                drawBond(atom1: atom1, atom2: dict[sortedKeys[i]]!, givenDist: sortedKeys[i])
                print(sortedKeys[i], "\t",  -((sortedKeys[i] - 0.8) / 0.7))
            }
        }
    }
    
//    drawBond(atom1: atoms[0], atom2: atoms[9], givenDist: 1.3)
//    drawBond(atom1: atoms[0], atom2: atoms[2], givenDist: 1.3)
    
    
    
    
    // Partial bonds
//    for atom1 in atoms {
//        var dict: [Double: SCNNode] = [:]
//        for atom2 in atoms {
//            let radius1 = Float(atomRadii[atom1.name!]?.covalentRadius ?? 0.0)
//            let radius2 = Float(atomRadii[atom2.name!]?.covalentRadius ?? 0.0)
//            let distance = (calculateDistance(node1: atom1, node2: atom2) - radius1 - radius2)
//
//            if distance > 0.8 && distance < 1.5 && atom1 != atom2 && atom2.name != "H" { // FIXME: There may be a problem with negative distance measurements
//                dict[Double(distance)] = atom2
//            }
//        }
//        let sortedKeys = Array(dict.keys.sorted(by: <))
//
//        for i in 0...(maxBonds[atom1.name ?? "He"] ?? 0) {
//            if i < sortedKeys.count {
//                drawBond(atom1: atom1, atom2: dict[sortedKeys[i]]!, givenDist: sortedKeys[i])
//                print(sortedKeys[i], "\t",  -((sortedKeys[i] - 0.8) / 0.7))
//            }
//        }
//    }
}

func drawBond(atom1: SCNNode, atom2: SCNNode, givenDist: Double) {
    let x1 = atom1.position.x
    let x2 = atom2.position.x
    
    let y1 = atom1.position.y
    let y2 = atom2.position.y
    
    let z1 = atom1.position.z
    let z2 = atom2.position.z
    
    let distance =  sqrtf( (x2-x1) * (x2-x1) +
                            (y2-y1) * (y2-y1) +
                            (z2-z1) * (z2-z1) )
    
    let baseGeometry = SCNCylinder(radius: 0.1, height: CGFloat(distance))
    baseGeometry.firstMaterial?.diffuse.contents = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1.00)
    
    let transparencyFactor = 1 - ((givenDist - 0.8) / 0.7)
    
    baseGeometry.firstMaterial?.transparency = CGFloat(transparencyFactor)
    
    let node = SCNNode(geometry: baseGeometry)
    node.position = SCNVector3(x: (x1 + x2) / 2,
                               y: (y1 + y2) / 2,
                               z: (z1 + z2) / 2)
    
    node.eulerAngles = SCNVector3(Float.pi / 2,
                                  acos((z2-z1)/(distance)),
                                  atan2((y2-y1),(x2-x1)))
    
    bonds.append(node)
    masterBond.addChildNode(node)
}

func updateBonds() {
    for bond in bonds {
        bond.removeFromParentNode()
    }
    
    bonds.removeAll()
    makeBonds()
}

func calculateDistance(node1: SCNNode, node2: SCNNode) -> Float {
    return sqrt(pow((node1.position.x - node2.position.x),2) + pow((node1.position.y - node2.position.y), 2) + pow((node1.position.z - node2.position.z), 2))
}
