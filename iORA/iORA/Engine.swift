//
//  Engine.swift
//  iORA
//
//  Created by Jeremiah Brown on 12/1/21.
//

import Foundation
import UIKit
import SceneKit

//engine puts all of the atoms from the data classes into SceneKit nodes that are then rendered in the scene setup section of the ViewController

class Engine {

    
    func initialDraw()
    {
        var fileLoader = FileLoader()
        
        let fileName = "sdfFiles/bullvalenetraj"
        
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: fileName, ofType: "sdf")

        guard let unwrappedPath = path else {
            return
        }
        
        let url = URL(fileURLWithPath: unwrappedPath)
        
        do {
            try fileLoader = fileLoader.parseReactionFile(inputFile: url)
        }
        catch
        {
            print(error)
        }
        
        //FIXME: below is the code to just implement one state, so I am pulling the first one. I need to add the ability to handle multiple states but that is for later
        
        let reaction = fileLoader.getReaction()
        
        let states: [State] = reaction.getStates()
        let atoms: [Atom] = states[0].atoms
        let bonds: [Bond] = states[0].bonds
        
        //draw atoms
        for atom in atoms
        {
            makeAtom(atomName: atom.symbol, coords: [atom.xPosition, atom.yPosition, atom.zPosition], scene: scene)
        }
        
        for bond in bonds
        {
            drawBond(atom1: bond.atom1, atom2: bond.atom2, givenDist: 1.0)
        }
    }
    
    
    func drawBond(atom1: Atom, atom2: Atom, givenDist: Double)
    {
        
        //to add once I get file loader updated to pull in number of bonds, ie. single, double
        //currently just updates all bonds to be triple
        //maybe add enum?
//        if (bondType == 1)
//        {
//            //do single bond stuff
//        }
//        if (bondType == 2)
//        {
//            //do double bond stuff
//        }
//        if (bondType == 3)
//        {
//            //do triple bond stuff
//        }
        
        let x1 = atom1.xPosition
        let x2 = atom2.xPosition
        
        let y1 = atom1.yPosition
        let y2 = atom2.yPosition
        
        let z1 = atom1.zPosition
        let z2 = atom2.zPosition
        
        let xdist = (x2-x1) * (x2-x1)
        let ydist = (y2-y1) * (y2-y1)
        let zdist = (z2-z1) * (z2-z1)
        
        let distance = sqrtf((Float(xdist + ydist + zdist)) * Float(distMult))
        
        let baseGeometry1 = SCNCylinder(radius: 0.06, height: CGFloat(distance))
        let baseGeometry2 = SCNCylinder(radius: 0.06, height: CGFloat(distance))
        let baseGeometry3 = SCNCylinder(radius: 0.06, height: CGFloat(distance))
        
        baseGeometry1.firstMaterial?.diffuse.contents = UIColor(red: 1.0, green: 0.75, blue: 0.75, alpha: 1.00)
        
        baseGeometry2.firstMaterial?.diffuse.contents = UIColor(red: 0.75, green: 1.0, blue: 0.75, alpha: 1.00)
        
        baseGeometry3.firstMaterial?.diffuse.contents = UIColor(red: 0.75, green: 0.75, blue: 1.0, alpha: 1.0)
        
        
        let transparencyFactor = 1 - ((givenDist - 0.8) / 0.7)
        
        baseGeometry1.firstMaterial?.transparency = CGFloat(transparencyFactor)
        
        baseGeometry2.firstMaterial?.transparency = CGFloat(transparencyFactor)
        
        baseGeometry3.firstMaterial?.transparency = CGFloat(transparencyFactor)
    
        
        let node1 = SCNNode(geometry: baseGeometry1)
        
        let node2 = SCNNode(geometry: baseGeometry2)
        
        let node3 = SCNNode(geometry: baseGeometry3)
        
        node1.position = SCNVector3(x: Float((x1 + x2) / 2),
                                    y: Float((y1 + y2) / 2),
                                    z: Float((z1 + z2) / 2) - 0.09)
        
        node2.position = SCNVector3(x: Float((x1 + x2) / 2),
                                    y: Float((y1 + y2) / 2),
                                    z: Float((z1 + z2) / 2) + 0.09)
        
        node3.position = SCNVector3(x: Float((x1 + x2) / 2) + 0.09,
                                    y: Float((y1 + y2) / 2) + 0.09,
                                    z: Float((z1 + z2) / 2) + 0.09)
        
        node1.eulerAngles = SCNVector3((Double(Float.pi)) / 2,
                                      acos((z2-z1)/Double((distance))),
                                      atan2((y2-y1),(x2-x1)))
        
        node2.eulerAngles = SCNVector3((Double(Float.pi)) / 2,
                                      acos((z2-z1)/Double((distance))),
                                      atan2((y2-y1),(x2-x1)))
        
        node3.eulerAngles = SCNVector3((Double(Float.pi)) / 2,
                                      acos((z2-z1)/Double((distance))),
                                      atan2((y2-y1),(x2-x1)))
        
        sceneBonds.append(node1)
        masterBond.addChildNode(node1)
        
        sceneBonds.append(node2)
        masterBond.addChildNode(node2)
        
        sceneBonds.append(node3)
        masterBond.addChildNode(node3)
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
        sceneAtoms.append(atomNode)
    }
    
    
}
