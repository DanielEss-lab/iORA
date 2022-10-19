//
//  TapActions.swift
//  iORA
//
//  Created by Jared Rossberg on 2/2/22.
//

import Foundation
import UIKit
import SceneKit
import SwiftUI

var selectedAtoms: [SCNNode] = []
let masterLine = SCNNode()

var atomMap: [Int:SCNNode] = [:]

extension ViewController {
    @objc func handleTap(rec: UITapGestureRecognizer) {
        let location: CGPoint = rec.location(in: self.sceneView)
        let hits = self.sceneView.hitTest(location, options: nil)
        if !hits.isEmpty {
            let tappedNode = hits.first?.node
            guard tappedNode!.name != nil else {
                return
            }
            
            if let atom = tappedNode, selectedAtoms.contains(atom) {
                unselectNode(atom)
            }
            else if selectedAtoms.count < 4 {
                selectNode(tappedNode)
            }
            
            removeLines()
            drawLines()
        }
    }
    
    func unselectNode(_ atom: SCNNode) {
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
    
    func selectNode(_ tappedNode: SCNNode?) {
        print("\n\n>>>>\t[", tappedNode!.position.x, tappedNode!.position.y, tappedNode!.position.z, "] Frame:", step)
        tappedNode?.addHighlight()
        selectedAtoms.append(tappedNode!)
        
        let selectedMaterial = SCNMaterial()
        tappedNode?.geometry?.firstMaterial = selectedMaterial
        
        SCNTransaction.begin()
        SCNTransaction.animationDuration = 0.0
        SCNTransaction.completionBlock = {
            SCNTransaction.animationDuration = 0.0
            selectedMaterial.emission.contents = UIColor.red
            selectedMaterial.shininess = 0.75
        }
        SCNTransaction.commit()
    }
    
    func updateLines() {
        removeLines()
        drawLines()
    }
    
    func removeLines() {
        for node in masterLine.childNodes {
            node.removeFromParentNode()
            node.removeAllActions()
        }
        infoView.view.removeFromSuperview()
    }
    
    func drawLines() {
        // TODO: figure out how to change infoView foreground color
        // set to white here
        if let color = UserDefaults.standard.backgroundColor {
            var r: CGFloat = 0
            var g: CGFloat = 0
            var b: CGFloat = 0
            var a: CGFloat = 0
            color.getRed(&r, green: &g, blue: &b, alpha: &a)
            // https://stackoverflow.com/questions/3942878/how-to-decide-font-color-in-white-or-black-depending-on-background-color
            if ((r * 0.299) + (g * 0.587) + (b * 0.114)) > (150 / 255) {
                // set to black here
            }
        }
        
        
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
                
                var dist = drawLine(a: a, b: b)
                
                infoView.rootView.labelData = String(format: "%0.2f", dist)
            }
            infoView.rootView.atoms = [selectedAtoms[0].name!, selectedAtoms[1].name!]
            infoView.rootView.labelName = "Distance"
            if selectedAtoms.count == 3 {
                infoView.rootView.atoms.append(selectedAtoms[2].name!)
                infoView.rootView.labelName = "Angle"
                
                var angle = calcAngle(a: selectedAtoms[0], b: selectedAtoms[1], c: selectedAtoms[2])
                angle = round(angle)
                
                infoView.rootView.labelData = String(Int(angle)) + "°"
            }
            if selectedAtoms.count == 4 {
                infoView.rootView.atoms.append(selectedAtoms[2].name!)
                infoView.rootView.atoms.append(selectedAtoms[3].name!)
                infoView.rootView.labelName = "Dihedral Angle"
                
                var angle = calcDihedral(a: selectedAtoms[0], b: selectedAtoms[1], c: selectedAtoms[2], d: selectedAtoms[3])
                angle = round(angle)
                
                infoView.rootView.labelData = String(Int(angle)) + "°"
                
                var triangle = drawTriangle(a: selectedAtoms[0], b: selectedAtoms[1], c: selectedAtoms[2])
                triangle.firstMaterial?.diffuse.contents = UIColor.yellow.withAlphaComponent(0.6)
                triangle = drawTriangle(a: selectedAtoms[1], b: selectedAtoms[2], c: selectedAtoms[3])
                triangle.firstMaterial?.diffuse.contents = UIColor.green.withAlphaComponent(0.6)
            }
        }
    }
    
    func drawTriangle(a: SCNNode, b: SCNNode, c: SCNNode) -> SCNGeometry {
        let vector1 = SCNVector3(a.position.x, a.position.y, a.position.z)
        let vector2 = SCNVector3(b.position.x, b.position.y, b.position.z)
        let vector3 = SCNVector3(c.position.x, c.position.y, c.position.z)
        
        let indices: [Int32] = [0, 1, 2]
        let source = SCNGeometrySource(vertices: [vector1, vector2, vector3])
        let element = SCNGeometryElement(indices: indices, primitiveType: .triangles)
        let geometry = SCNGeometry(sources: [source], elements: [element])
        
        geometry.firstMaterial?.isDoubleSided = true
        let node = SCNNode(geometry: geometry)
        masterLine.addChildNode(node)
        return geometry
    }
    
    func calcDihedral(a: SCNNode, b: SCNNode, c: SCNNode, d: SCNNode) -> Float {
        let x1 = a.position.x, y1 = a.position.y, z1 = a.position.z
        let x2 = b.position.x, y2 = b.position.y, z2 = b.position.z
        let x3 = c.position.x, y3 = c.position.y, z3 = c.position.z
        let x4 = d.position.x, y4 = d.position.y, z4 = d.position.z
        
        let B1x = x2 - x1, B1y = y2 - y1, B1z = z2 - z1
        let B2x = x3 - x2, B2y = y3 - y2, B2z = z3 - z2
        let B3x = x4 - x3, B3y = y4 - y3, B3z = z4 - z3
        
        let modB2 = sqrt(pow(B2x, 2) + pow(B2y, 2) + pow(B2z, 2))
        
        // yAx is x-coord. etc of modulus of B2 times B1
        let yAx = modB2 * B1x
        let yAy = modB2 * B1y
        let yAz = modB2 * B1z
        
        // CP2 is the crossproduct of B2 and B3
        let CP2x = (B2y * B3z) - (B2z * B3y)
        let CP2y = (B2z * B3x) - (B2x * B3z)
        let CP2z = (B2x * B3y) - (B2y * B3x)
        let termY = (yAx * CP2x) + (yAy * CP2y) + (yAz * CP2z)
        
        // CP is the crossproduct of B1 and B2
        let CPx = (B1y * B2z) - (B1z * B2y)
        let CPy = (B1z * B2x) - (B1x * B2z)
        let CPz = (B1x * B2y) - (B1y * B2x)
        let termX = (CPx * CP2x) + (CPy * CP2y) + (CPz * CP2z)
        
        let dihed4 = atan2(termY, termX)  * 180 / Float(Double.pi)
        return dihed4
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
        
        let line = SCNCylinder(radius: 0.02, height: Double(dist))
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
