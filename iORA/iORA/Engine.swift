//
//  Engine.swift
//  iORA
//
//  Created by Jeremiah Brown on 12/1/21.
//

//Gabe implemnted the animation by moving the objects, his way of animating may have been more efficient. We are simply recreating the object in a different posistion each time. This may make the atoms prone to a jitter. Not quite sure yet. For now, this is an ok implementation, but we may want to consider moving to Gabe's method once we iron out the bugs in our current version.

import Foundation
import UIKit
import SceneKit

//engine puts all of the atoms from the data classes into SceneKit nodes that are then rendered in the scene setup section of the ViewController

var states = [State]()
var currentAtoms = [Atom]()
var currentBonds = [Bond]()

let RADIUS = 0.04

class Engine {
    
    func getStates()->[State]
        {
            return states
        }
        func getAtoms()->[Atom]
        {
            return currentAtoms
        }
        func getBonds()->[Bond]
        {
            return currentBonds
        }
    
    func initialDraw() {
        let fileLoader = FileLoader()
        let fileName = "sdfFiles/" + globalReaction
        let bundle = Bundle.main
        let path = bundle.path(forResource: fileName, ofType: "sdf")
        guard let unwrappedPath = path else {
            return
        }
        let url = URL(fileURLWithPath: unwrappedPath)
        
        let reaction: Reaction
        do {
            reaction = try fileLoader.parseReactionFile(inputFile: url).getReaction()
        }
        catch {
            print(error)
            return
        }
        
        //FIXME: below is the code to just implement one state, so I am pulling the first one. I need to add the ability to handle multiple states but that is for later
        
        states = reaction.getStates()
        currentAtoms = states[0].atoms
        currentBonds = states[0].bonds
        
        // reset scene
        for atom in sceneAtoms {
            atom.removeAllActions()
            atom.removeFromParentNode()
        }
        for bond in sceneBonds {
            bond.removeAllActions()
            bond.removeFromParentNode()
        }
        atomActions.removeAll()
        sceneAtoms.removeAll()
        sceneBonds.removeAll()
        
        //draw atoms
        for atom in currentAtoms {
            makeAtom(atomName: atom.symbol, coords: [atom.xPosition, atom.yPosition, atom.zPosition], scene: scene)
        }
        for bond in currentBonds {
            drawBond(bond: bond, givenDist: 1.0)
        }
    }
    
    
    func drawBond(bond: Bond, givenDist: Double)
    {
        let atom1 = bond.atom1
        let atom2 = bond.atom2
        
        let x1 = Float(atom1.xPosition)
        let x2 = Float(atom2.xPosition)
        
        let y1 = Float(atom1.yPosition)
        let y2 = Float(atom2.yPosition)
        
        let z1 = Float(atom1.zPosition)
        let z2 = Float(atom2.zPosition)
        
        let coordinates: [Float] = [x1, x2, y1, y2, z1, z2]
        
        let xdist = (x2-x1) * (x2-x1)
        let ydist = (y2-y1) * (y2-y1)
        let zdist = (z2-z1) * (z2-z1)
        
        let distance = sqrtf((Float(xdist + ydist + zdist)) * Float(distMult))
        
        let transparencyFactor = 1 - ((givenDist - 0.8) / 0.7)
        
        if ( bond.order == 1)
        {
            drawSingle(distance: distance, c: coordinates, transparencyFactor: transparencyFactor)
        }
        else if (bond.order == 2)
        {
            drawDouble(distance: distance, c: coordinates, transparencyFactor: transparencyFactor)
        }
        else if (bond.order == 3)
        {
            drawTriple(distance: distance, c: coordinates, transparencyFactor: transparencyFactor)
        }
        else if (bond.order == 0.5)
        {
            drawOnePartial(distance: distance, c: coordinates, transparencyFactor: transparencyFactor, xdist: xdist, ydist: ydist)
        }
        //FIXME: Need to add other partial bonds, but for now anything that is not a normal bond will be single partial
        else
        {
            drawOnePartial(distance: distance, c: coordinates, transparencyFactor: transparencyFactor, xdist: xdist, ydist: ydist)
        }
        
        
    }
    
    func drawSingle(distance: Float, c: [Float], transparencyFactor: Double)
    {
        let baseGeometry1 = SCNCylinder(radius: 0.06, height: CGFloat(distance))
        baseGeometry1.firstMaterial?.diffuse.contents = UIColor(red: 1.0, green: 0.75, blue: 0.75, alpha: 1.00)
        baseGeometry1.firstMaterial?.transparency = CGFloat(transparencyFactor)
        
        let node1 = SCNNode(geometry: baseGeometry1)
        node1.position = SCNVector3(x: Float((c[0] + c[1]) / 2),
                                    y: Float((c[2] + c[3]) / 2),
                                    z: Float((c[4] + c[5]) / 2))
        node1.eulerAngles = SCNVector3((Float.pi / 2),
                                       acos((c[5]-c[4])/Float((distance))),
                                       atan2((c[3]-c[2]),(c[1]-c[0])))
        
        sceneBonds.append(node1)
        masterBond.addChildNode(node1)
    }
    
    func drawDouble(distance: Float, c: [Float], transparencyFactor: Double)
    {
        let baseGeometry1 = SCNCylinder(radius: 0.06, height: CGFloat(distance))
        let baseGeometry2 = SCNCylinder(radius: 0.06, height: CGFloat(distance))
        baseGeometry1.firstMaterial?.diffuse.contents = UIColor(red: 1.0, green: 0.75, blue: 0.75, alpha: 1.00)
        baseGeometry2.firstMaterial?.diffuse.contents = UIColor(red: 0.75, green: 1.0, blue: 0.75, alpha: 1.00)
        baseGeometry1.firstMaterial?.transparency = CGFloat(transparencyFactor)
        baseGeometry2.firstMaterial?.transparency = CGFloat(transparencyFactor)
        
        let node1 = SCNNode(geometry: baseGeometry1)
        let node2 = SCNNode(geometry: baseGeometry2)
        node1.position = SCNVector3(x: Float((c[0] + c[1]) / 2),
                                    y: Float((c[2] + c[3]) / 2),
                                    z: Float((c[4] + c[5]) / 2) - 0.09)
        node2.position = SCNVector3(x: Float((c[0] + c[1]) / 2),
                                    y: Float((c[2] + c[3]) / 2),
                                    z: Float((c[4] + c[5]) / 2) + 0.09)
        node1.eulerAngles = SCNVector3((Float.pi / 2),
                                       acos((c[5]-c[4])/Float((distance))),
                                       atan2((c[3]-c[2]),(c[1]-c[0])))
        node2.eulerAngles = SCNVector3((Float.pi / 2),
                                       acos((c[5]-c[4])/Float((distance))),
                                       atan2((c[3]-c[2]),(c[1]-c[0])))
        
        sceneBonds.append(node1)
        masterBond.addChildNode(node1)
        
        sceneBonds.append(node2)
        masterBond.addChildNode(node2)
    }
    
    func drawTriple(distance: Float, c: [Float], transparencyFactor: Double)
    {
        let baseGeometry1 = SCNCylinder(radius: 0.06, height: CGFloat(distance))
        let baseGeometry2 = SCNCylinder(radius: 0.06, height: CGFloat(distance))
        let baseGeometry3 = SCNCylinder(radius: 0.06, height: CGFloat(distance))
        
        baseGeometry1.firstMaterial?.diffuse.contents = UIColor(red: 1.0, green: 0.75, blue: 0.75, alpha: 1.00)
        baseGeometry2.firstMaterial?.diffuse.contents = UIColor(red: 0.75, green: 1.0, blue: 0.75, alpha: 1.00)
        baseGeometry3.firstMaterial?.diffuse.contents = UIColor(red: 0.75, green: 0.75, blue: 1.0, alpha: 1.0)
    
        
        baseGeometry1.firstMaterial?.transparency = CGFloat(transparencyFactor)
        baseGeometry2.firstMaterial?.transparency = CGFloat(transparencyFactor)
        baseGeometry3.firstMaterial?.transparency = CGFloat(transparencyFactor)
    
        
        let node1 = SCNNode(geometry: baseGeometry1)
        let node2 = SCNNode(geometry: baseGeometry2)
        let node3 = SCNNode(geometry: baseGeometry3)
        
        node1.position = SCNVector3(x: Float((c[0] + c[1]) / 2),
                                    y: Float((c[2] + c[3]) / 2),
                                    z: Float((c[4] + c[5]) / 2) - 0.09)
        
        node2.position = SCNVector3(x: Float((c[0] + c[1]) / 2),
                                    y: Float((c[2] + c[3]) / 2),
                                    z: Float((c[4] + c[5]) / 2) + 0.09)
        
        node3.position = SCNVector3(x: Float((c[0] + c[1]) / 2) + 0.09,
                                    y: Float((c[2] + c[3]) / 2) + 0.09,
                                    z: Float((c[4] + c[5]) / 2) + 0.09)
        
        node1.eulerAngles = SCNVector3((Float.pi / 2),
                                       acos((c[5]-c[4])/Float((distance))),
                                       atan2((c[3]-c[2]),(c[1]-c[0])))
        
        node2.eulerAngles = SCNVector3((Float.pi / 2),
                                       acos((c[5]-c[4])/Float((distance))),
                                       atan2((c[3]-c[2]),(c[1]-c[0])))
        
        node3.eulerAngles = SCNVector3((Float.pi / 2),
                                       acos((c[5]-c[4])/Float((distance))),
                                       atan2((c[3]-c[2]),(c[1]-c[0])))
        
        sceneBonds.append(node1)
        masterBond.addChildNode(node1)
        
        sceneBonds.append(node2)
        masterBond.addChildNode(node2)
        
        sceneBonds.append(node3)
        masterBond.addChildNode(node3)
    }
    
    func drawOnePartial(distance: Float, c: [Float], transparencyFactor: Double, xdist: Float, ydist: Float)
    {
        
        let baseGeometry1 = SCNCylinder(radius: RADIUS, height: CGFloat(distance))
        
        baseGeometry1.firstMaterial?.diffuse.contents = UIImage(named: "line")!
        //baseGeometry1.firstMaterial?.transparency = CGFloat(transparencyFactor)
        baseGeometry1.firstMaterial?.diffuse.wrapS = .repeat
        baseGeometry1.firstMaterial?.diffuse.wrapT = .repeat
        baseGeometry1.firstMaterial?.isDoubleSided = true
        
        let width = Float(RADIUS)
        let height = Float(distance)
        let repeatCountPerMeter = Float(8)
        
        baseGeometry1.firstMaterial?.diffuse.contentsTransform = SCNMatrix4MakeScale(width * repeatCountPerMeter, height * repeatCountPerMeter, 1)
        
        let node1 = SCNNode(geometry: baseGeometry1)
        node1.position = SCNVector3(x: Float((c[0] + c[1]) / 2),
                                    y: Float((c[2] + c[3]) / 2),
                                    z: Float((c[4] + c[5]) / 2))
        node1.eulerAngles = SCNVector3((Float.pi / 2),
                                       acos((c[5]-c[4])/Float((distance))),
                                       atan2((c[3]-c[2]),(c[1]-c[0])))
        
        sceneBonds.append(node1)
        masterBond.addChildNode(node1)
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
        
        //uncomment this to restore atomActions
        //atomActions[atomNode] = AtomInfo(positions: [SCNVector3(coords[0], coords[1], coords[2])], actions: [])
        sceneAtoms.append(atomNode)
    }
    
    func drawState(stateNum: Int)
    {
        currentAtoms.removeAll()
        currentBonds.removeAll()
        currentAtoms = states[stateNum].atoms
        currentBonds = states[stateNum].bonds
        
        sceneBonds.removeAll()
        sceneAtoms.removeAll()
        masterAtom.enumerateChildNodes
        { (node, stop) in
                node.removeFromParentNode()
        }
        masterBond.enumerateChildNodes
        { (node, stop) in
                node.removeFromParentNode()
        }
        
        
        
        //draw atoms
        for atom in currentAtoms
        {
            makeAtom(atomName: atom.symbol, coords: [atom.xPosition, atom.yPosition, atom.zPosition], scene: scene)
        }
        
        for bond in currentBonds
        {
            drawBond(bond: bond, givenDist: 1.0)
        }
    }
    
}
