//
//  ParseXYZ.swift
//  iORA
//
//  Created by Gabriel Reed on 1/4/21.
//

import Foundation
import SceneKit

//struct AtomInfo {
//    var positions: [SCNVector3]
//    var actions: [SCNAction]
//}

func parseXYZ(inputFile: String) {
    let path = Bundle.main.path(forResource: inputFile, ofType: "xyz")
    let source = try? String.init(contentsOfFile: path!)
    let elements = source?.components(separatedBy: "\n")
    
    var moleculeNumber = -1
    var i = 0
    
    for element in elements! {
        
        var name: String = ""
        var coords: [Double] = []
        
        
        let replaced = element.replacingOccurrences(of: "\t", with: " ")
        let parts = replaced.components(separatedBy: " ")
        
        if parts.count > 1 {
            name = parts[0]
            if let x: Double = Double(parts[1]) {
                coords.append(x * scaleFactor)
                if abs(x) > maxX {
                    maxX = abs(x)
                }
            }
            if let y = Double(parts[2]) {
                coords.append(y * scaleFactor)
                if abs(y) > maxY {
                    maxY = abs(y)
                }
            }
            if let z = Double(parts[3]) {
                coords.append(z * scaleFactor)
                if abs(z) > maxZ {
                    maxZ = abs(z)
                }
            }
            
            if moleculeNumber <= 1 {
                makeAtom(atomName: name, coords: coords, scene: scene)
            }
            else {
                updateAtom(atomName: name, coords: coords, scene: scene, i: i)
                i += 1
            }
            
        }
        else if parts.count == 1 {
            moleculeNumber += 1
            i = 0
        }
    }
}


func makeAtom(atomName: String, coords: [Double], scene: SCNScene) {
    guard let radius = atomRadii[atomName]?.customRadius,
          let color = atomRadii[atomName]?.color else { return }
    
    let atomGeometry = SCNSphere(radius: CGFloat(radius))
    let atomMaterial = SCNMaterial()
    atomMaterial.diffuse.contents = color
    atomMaterial.specular.contents = UIColor.white
    atomMaterial.shininess = 0.75
    atomGeometry.materials = [atomMaterial]
    let atomNode = SCNNode(geometry: atomGeometry)
    atomNode.position = SCNVector3(coords[0], coords[1], coords[2])
    atomNode.name = atomName
    masterAtom.addChildNode(atomNode)
    
    atomActions[atomNode] = AtomInfo(positions: [SCNVector3(coords[0], coords[1], coords[2])], actions: [])
    atoms.append(atomNode)
}


func updateAtom(atomName: String, coords: [Double], scene: SCNScene, i: Int) {
    let action = SCNAction.move(to: SCNVector3(coords[0], coords[1], coords[2]), duration: stepDuration)
    atomActions[atoms[i]]?.actions.append(action)
    atomActions[atoms[i]]?.positions.append(SCNVector3(coords[0], coords[1], coords[2]))
}
