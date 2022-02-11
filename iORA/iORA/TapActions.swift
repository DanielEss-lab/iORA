//
//  TapActions.swift
//  iORA
//
//  Created by Jared Rossberg on 2/2/22.
//

import Foundation
import UIKit
import SceneKit

var selectedAtoms: [SCNNode] = []
let masterLine = SCNNode()

extension ViewController {
    @objc func handleTap(rec: UITapGestureRecognizer) {
        let location: CGPoint = rec.location(in: self.sceneView)
        let hits = self.sceneView.hitTest(location, options: nil)
        if !hits.isEmpty {
            let tappedNode = hits.first?.node
            guard tappedNode!.name != nil else {
                return
            }
            
            // Unselect node if already selected
            if let atom = tappedNode, selectedAtoms.contains(atom) {
                atom.removeHighlight()
            
                let color = atomRadii[atom.name!]?.color
                let atomMaterial = SCNMaterial()
                atomMaterial.diffuse.contents = color
                atomMaterial.specular.contents = UIColor.white
                atomMaterial.shininess = 0.75
                atom.geometry?.materials = [atomMaterial]
                
                if let index = selectedAtoms.firstIndex(of: atom) {
                    selectedAtoms.remove(at: index)
                }
            }
            // Select node if not already selected
            else if selectedAtoms.count < 3 {
                tappedNode?.addHighlight()
                selectedAtoms.append(tappedNode!)
                
                let selectedMaterial = SCNMaterial()
                tappedNode?.geometry?.firstMaterial = selectedMaterial
                
                SCNTransaction.begin()
                SCNTransaction.animationDuration = 0.5
                SCNTransaction.completionBlock = {
                    SCNTransaction.animationDuration = 0.5
                    selectedMaterial.emission.contents = UIColor.red
                    selectedMaterial.shininess = 0.75
                }
                SCNTransaction.commit()
            }
            
            // Remove all existing lines
            for node in masterLine.childNodes {
                node.removeFromParentNode()
                node.removeAllActions()
            }
            infoView.view.removeFromSuperview()
            
            // Draw lines between selected atoms
            if selectedAtoms.count > 0 {
                view.addSubview(infoView.view)
                infoView.rootView.atoms = []
                infoView.rootView.labelName = "Element"
                infoView.rootView.labelData = selectedAtoms[0].name!
            }
            if selectedAtoms.count > 1 {
                for i in 1..<selectedAtoms.count {
                    let a = selectedAtoms[i-1]
                    let b = selectedAtoms[i]
                    
                    let dist = drawLine(a: a, b: b)
                    
                    infoView.rootView.labelData = String(dist)
                }
                infoView.rootView.atoms = [selectedAtoms[0].name!, selectedAtoms[1].name!]
                infoView.rootView.labelName = "Distance"
                if selectedAtoms.count == 3 {
                    infoView.rootView.atoms.append(selectedAtoms[2].name!) 
                    infoView.rootView.labelName = "Angle"
                    infoView.rootView.labelData = String(calcAngle(a: selectedAtoms[0], b: selectedAtoms[1], c: selectedAtoms[2])) + "°"
                }
            }
            
        }
    }
    
    func calcDist(a: SCNNode, b: SCNNode) -> Float {
        let x1 = a.position.x, y1 = a.position.y, z1 = a.position.z
        let x2 = b.position.x, y2 = b.position.y, z2 = b.position.z
        
        return sqrt(pow((x1 - x2), 2) + pow((y1 - y2), 2) + pow((z1 - z2), 2))
    }
    
    func calcAngle(a: SCNNode, b: SCNNode, c: SCNNode) -> Float {
        let x2 = b.position.x, y2 = b.position.y, z2 = b.position.z
        let x1 = a.position.x - x2,
            y1 = a.position.y - y2,
            z1 = a.position.z - z2
        let x3 = c.position.x - x2,
            y3 = c.position.y - y2,
            z3 = c.position.z - z2
        
        let magnitude1 = calcDist(a: a, b: b)
        let magnitude2 = calcDist(a: b, b: c)
        let dotProduct = (x1 * x3) + (y1 * y3) + (z1 * z3)
        
        let angle = acos(dotProduct / (magnitude1 * magnitude2))
        return angle * 180 / Float(Double.pi)
    }
    
    func drawLine(a: SCNNode, b: SCNNode) -> Float {
        let x1 = a.position.x, y1 = a.position.y, z1 = a.position.z
        let x2 = b.position.x, y2 = b.position.y, z2 = b.position.z
        
        let dist = calcDist(a: a, b: b)
        
        let line = SCNCylinder(radius: 0.01, height: Double(dist))
        line.firstMaterial?.diffuse.contents = UIColor.red
        let node = SCNNode(geometry: line)
        node.position = SCNVector3(x: (x1 + x2) / 2, y: (y1 + y2) / 2, z: (z1 + z2) / 2)
        node.eulerAngles = SCNVector3(Float.pi / 2, acos((z2-z1)/dist), atan2((y2-y1),(x2-x1)))
        masterLine.addChildNode(node)
        
        return dist
    }
}



extension SCNNode {
    func addHighlight( _ highlighted : Bool = true, _ highlightedBitMask : Int = 2 ) {
        /*categoryBitMask = highlightedBitMask
        for child in self.childNodes {
            child.addHighlight()
        }*/
    }
    
    func removeHighlight() {
        /*categoryBitMask = 1
        for child in self.childNodes {
            child.removeHighlight()
        }*/
    }
}
