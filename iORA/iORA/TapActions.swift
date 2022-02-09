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
            else if selectedAtoms.count < 2 {
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
            if selectedAtoms.count > 1 {
                view.addSubview(infoView.view)
                for i in 1...(selectedAtoms.count-1) {
                    let a = selectedAtoms[i-1]
                    let b = selectedAtoms[i]
                    
                    let x1 = a.position.x, y1 = a.position.y, z1 = a.position.z
                    let x2 = b.position.x, y2 = b.position.y, z2 = b.position.z
                    
                    let dist = sqrt(pow((x1 - x2), 2) + pow((y1 - y2), 2) + pow((z1 - z2), 2))
                    
                    let line = SCNCylinder(radius: 0.01, height: Double(dist))
                    line.firstMaterial?.diffuse.contents = UIColor.red
                    let node = SCNNode(geometry: line)
                    node.position = SCNVector3(x: (x1 + x2) / 2, y: (y1 + y2) / 2, z: (z1 + z2) / 2)
                    node.eulerAngles = SCNVector3(Float.pi / 2, acos((z2-z1)/dist), atan2((y2-y1),(x2-x1)))
                    masterLine.addChildNode(node)
                    
                    infoView.rootView.atom1 = a.name!
                    infoView.rootView.atom2 = b.name!
                    infoView.rootView.dist = String(dist)
                }
            }
            
        }
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
