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

func handleAtomTap(rec: UITapGestureRecognizer, caller: ViewController) {
    let location: CGPoint = rec.location(in: caller.sceneView)
    let hits = caller.sceneView.hitTest(location, options: nil)
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
            return
        }
        
        
        tappedNode?.addHighlight()
        selectedAtoms.append(tappedNode!)
        
        let selectedMaterial = SCNMaterial()
        let color = atomRadii[tappedNode?.name! ?? "H"]?.color
        selectedMaterial.diffuse.contents = color
        
        tappedNode?.geometry?.firstMaterial = selectedMaterial
        
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 0.5
        SCNTransaction.completionBlock = {
            SCNTransaction.begin()
            SCNTransaction.animationDuration = 0.5
            selectedMaterial.emission.contents = UIColor.black
            SCNTransaction.commit()
        }
        
        selectedMaterial.emission.contents = UIColor.red
        SCNTransaction.commit()
    }
}

extension SCNNode {
    func addHighlight( _ highlighted : Bool = true, _ highlightedBitMask : Int = 2 ) {
        categoryBitMask = highlightedBitMask
        for child in self.childNodes {
            child.addHighlight()
        }
    }
    
    func removeHighlight() {
        categoryBitMask = 1
        for child in self.childNodes {
            child.removeHighlight()
        }
    }
}
