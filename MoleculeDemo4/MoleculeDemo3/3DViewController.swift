//
//  ViewController.swift
//  MoleculeDemo3
//
//  Created by Gabriel Reed on 8/25/20.
//  Copyright © 2020 Gabriel Reed. All rights reserved.
//

/*
 MARK: TO DO:
 - Play/Pause icons are slightly different sizes?
 - Sideways functionality?
 - Figure out camera constantly zooming (code commented out in animate())
 
 
 - [DONE] Get full animation (1000 frames of each side)
 - Get right number of bonds
 - Interrogations
    - [DONE] Don't need position
    - [DONE] Angles
    - Dihedral angles
    - Instead of steps at bottom, some indicator at the transition state (the zero between the two)
 - [DONE] Button in bottom left corner that says TS that will take you to the transition state
 - [DONE] Make camera be able to track an atom
 - [DONE] Make it so you can choose different radii
 
 
 */
// MARK:-

import UIKit
import SceneKit

class MoleculeViewController: UIViewController {
    
    @IBOutlet weak var sceneView: SCNView!
    let cameraNode = SCNNode()
    
    var atoms: [SCNAtom] = []
    var atomNodes: [SCNNode] = []
    var selectedAtoms: [SCNNode] = []
    var bondsUnused: [SCNBond] = []
    var bondNodes: [SCNNode] = []
    
    var testBonds: [SCNBond] = []
    var testBondNodes: [SCNNode] = []
    
    @IBOutlet weak var firstAtomNameLabel: UILabel!
    @IBOutlet weak var secondAtomNameLabel: UILabel!
    @IBOutlet weak var thirdAtomNameLabel: UILabel!
    @IBOutlet weak var fourthAtomNameLabel: UILabel!
    @IBOutlet weak var doneSelectingButton: UIButton!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var stepSlider: UISlider!
    @IBOutlet weak var stepAheadButton: UIButton!
    @IBOutlet weak var skipAheadButton: UIButton!
    @IBOutlet weak var skipToEndButton: UIButton!
    @IBOutlet weak var stepBackButton: UIButton!
    @IBOutlet weak var skipBackButton: UIButton!
    @IBOutlet weak var skipToBeginningButton: UIButton!
    @IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var loopButton: UIButton!
    @IBOutlet weak var speedSlider: UISlider!
    @IBOutlet weak var lockCameraButton: UIButton!
    
    var lockNode: [SCNNode] = []
    
    let scaleFactor = 1.0
    var stepDuration = 0.02 // Default = 0.02
    let maxStep = 0.1
    let minStep = 0.005
    var step = 0
    var isAnimating = true
    var isReverse = false
    var isLooping = true
    
    var timer = Timer()
    
    var maxX = 0.0
    var maxY = 0.0
    var maxZ = 0.0
    
    var inputFileName = ""
    
    var selectedAtomRadius = 2
    
    let scene = SCNScene()
    
    // MARK:-
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(rec:)))
        sceneView.addGestureRecognizer(tap)
        
//        parseXYZ(inputFile: inputFileName, scene: scene)
//        parseXYZ(inputFile: "OH-EtBr-SN2-traj5", scene: scene)
        parseXYZ(inputFile: "SN2", scene: scene)
        updateBonds()
        
//        sortAtoms()

        
        
        
        print(round(maxX), round(maxY), round(maxZ))
        print(getCameraPosition(maxX: maxX, maxY: maxY, maxZ: maxZ))
        
        hideAtomInfo()
        stepLabel.text = "Step: \(step) / \(atoms[0].actions.count - 1)"
        lockCameraButton.isHidden = true
        
        stepSlider.maximumValue = Float(atoms[0].actions.count)
        speedSlider.maximumValue = Float(maxStep)
        speedSlider.minimumValue = Float(minStep)
        
        // Camera
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: getCameraPosition(maxX: maxX, maxY: maxY, maxZ: maxZ))
        scene.rootNode.addChildNode(cameraNode)
        sceneView.defaultCameraController.frameNodes(atomNodes)
        
        // Scene light
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .omni
        lightNode.position = SCNVector3(x: -40, y: 40, z: 35)
        scene.rootNode.addChildNode(lightNode)
        
        // Ambient light
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light?.type = .ambient
        ambientLightNode.light?.color = UIColor.darkGray
        ambientLightNode.position = SCNVector3(0.0, 0.0, -20.0)
        ambientLightNode.light?.intensity = 600 // Default 3500
        scene.rootNode.addChildNode(ambientLightNode)
        
        // Atom animation & label updates
        if atoms[0].actions.count > 0 {
            weak var pass = self
            timer = Timer.scheduledTimer(timeInterval: stepDuration, target: pass as Any,
                                 selector: #selector(animate), userInfo: nil, repeats: true)
        }
        
        // ATOM GLOW
        if let path = Bundle.main.path(forResource: "NodeTechnique", ofType: "plist") {
            if let dict = NSDictionary(contentsOfFile: path)  {
                let dict2 = dict as! [String : AnyObject]
                let technique = SCNTechnique(dictionary:dict2)
                
                // Set glow color
                let color = SCNVector3(1.0, 0.0, 0.0)
                technique?.setValue(NSValue(scnVector3: color), forKeyPath: "glowColorSymbol")
                
                sceneView.technique = technique 
            }
        }
        
        // BACKGROUND COLORS
//        sceneView.backgroundColor = UIColor(red: 0.51, green: 0.51, blue: 0.78, alpha: 1.00) // Blue
//        sceneView.backgroundColor = UIColor.white                                            // White
//        sceneView.backgroundColor = UIColor(red: 0.27, green: 0.27, blue: 0.27, alpha: 1.00) // Dark gray
        sceneView.backgroundColor = UIColor(red: 0.09, green: 0.28, blue: 0.59, alpha: 1.00) // Dark blue
        
        sceneView.allowsCameraControl = true         // Allow user to manipulate camera
//        sceneView.showsStatistics = true             // Show FPS logs and timing
//        sceneView.rendersContinuously = true
        sceneView.scene = scene
    }
    
    func sortAtoms() {
        atoms = atoms.sorted(by: { $0.bondNum < $1.bondNum })
//        atomNodes = atomNodes.sorted(by: { $0.name < $1. })
        // FIXME: There needs to be a way to sort atomNodes
            // Could I make an extension of SCNNode to include bondNum and then just kinda use that?
            // Alternatively, make a subclass of SCNNode that is an atomNode with a bondNum property 
    }
    
    @objc func animate() {
        if isAnimating {
            if isLooping {
                if step == atoms[0].actions.count && !isReverse {
                    step = 0
                }
                else if step == 0 && isReverse {
                    step = atoms[0].actions.count - 1
                }
            }
            if step > -1 && step < atoms[0].actions.count {
                var i = 0
                for atom in atomNodes {
                    atom.runAction(atoms[i].actions[step])
                    i += 1
                }
                
                updateBonds()
                
                i = 0
                if isReverse {
                    step -= 1
                }
                else {
                    step += 1
                }
                
                updateLabels()
            }
            
            // FIXME: Put this as an option you can turn on in the (i) menu
            // FIXME: There's probably a better way to do this that's built in
            maxX = 0.0
            maxY = 0.0
            maxZ = 0.0
            for atom in atomNodes {
                if Double(atom.position.x) > maxX {
                    maxX = Double(atom.position.x)
                }
                if Double(atom.position.y) > maxY {
                    maxY = Double(atom.position.y)
                }
                if Double(atom.position.z) > maxZ {
                    maxZ = Double(atom.position.z)
                }
            }
//            cameraNode.position = SCNVector3(cameraNode.position.x, cameraNode.position.y, getCameraPosition(maxX: maxX, maxY: maxY, maxZ: maxZ))
        }
        else {
            var i = 0
            for atom in atomNodes {
                atom.position = atoms[i].positions[step]
                i += 1
            }
            i = 0
            
            updateBonds()
        }
        stepSlider.value = Float(step)
    }

    @IBAction func playPauseButtonTapped(_ sender: Any) {
        let playBtn = sender as! UIButton
        
        sceneView.scene?.isPaused = !(sceneView.scene!.isPaused)
        isAnimating = !isAnimating
        
        if sceneView.scene!.isPaused {
            playBtn.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
        else {
            playBtn.setImage(UIImage(systemName: "pause.fill"), for: .normal)
        }
    }
    
    @IBAction func stepSliderChanged(_ sender: Any) {
        step = Int(stepSlider.value)
        updateLabels()
    }
    
    @IBAction func speedSliderChanged(_ sender: Any) {
        timer = Timer.scheduledTimer(timeInterval: TimeInterval(speedSlider.value), target: self,
                                     selector: #selector(animate), userInfo: nil, repeats: true)
        
//        stepDuration = Double(speedSlider.value)
        updateLabels()
        print(speedSlider.value)
    }
    
    func parseXYZ(inputFile: String, scene: SCNScene) {
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
        guard let radius = atomRadii[atomName]?.covalentRadius,
            let color = atomRadii[atomName]?.color else { return }
        
        atoms.append(SCNAtom(name: atomName, x: coords[0], y: coords[1], z: coords[2], radius: radius, positions: [SCNVector3(coords[0], coords[1], coords[2])], actions: [], bondedTo: []))
        
        let atomGeometry = SCNSphere(radius: CGFloat(radius))
        let atomMaterial = SCNMaterial()
        atomMaterial.diffuse.contents = color
//        atomMaterial.specular.contents = UIColor.white // FIXME: Will cause the app to randomly crash
        atomMaterial.shininess = 0.75
        atomGeometry.materials = [atomMaterial]
        let atomNode = SCNNode(geometry: atomGeometry)
        atomNode.position = SCNVector3(coords[0], coords[1], coords[2])
        atomNode.name = atomName
        scene.rootNode.addChildNode(atomNode)
        
        atomNodes.append(atomNode)
    }
    
    func updateAtom(atomName: String, coords: [Double], scene: SCNScene, i: Int) {
        let action = SCNAction.move(to: SCNVector3(coords[0], coords[1], coords[2]), duration: stepDuration)
        atoms[i].actions.append(action)
        atoms[i].positions.append(SCNVector3(coords[0], coords[1], coords[2]))
    }
    
//    func makeBonds(scene: SCNScene) {
//        /*
//         For each atom, check how many bonds it can make total. Then get the closest atoms to it and make the bonds.
//         */
//
//        var i = 0
//        for atom in atomNodes {
//            if i < atomNodes.count - 1 {
//                addLine(start: atom.position, end: atomNodes[i + 1].position, scene: scene)
//                bonds.append(Bond(atom1: atom, atom2: atomNodes[i + 1]))
//            }
//            i += 1
//        }
//        addLine(start: atomNodes[0].position, end: atomNodes[atomNodes.count - 1].position, scene: scene)
//        bonds.append(Bond(atom1: atomNodes[0], atom2: atomNodes[atomNodes.count - 1]))
//    }
    
//    func addLine(start: SCNVector3, end: SCNVector3, scene: SCNScene) {
//
//        let cylinderLineNode = SCNGeometry.cylinderLine(from: start,
//                                                        to: end,
//                                                        segments: 6)
//
//        bondNodes.append(cylinderLineNode)
//
//        scene.rootNode.addChildNode(cylinderLineNode)
//    }

    @objc func handleTap(rec: UITapGestureRecognizer){
        // FIXME: Has to make sure that it's actually an atom and not a bond or something else
        if rec.state == .ended {
            let location: CGPoint = rec.location(in: sceneView)
            let hits = self.sceneView.hitTest(location, options: nil)
            if !hits.isEmpty{
                let tappedNode = hits.first?.node
                
                guard tappedNode!.name != nil else { // Checks to make sure it has a name (basically meaning that it's an atom)
                    // I could also extend the node class to include a "type" that would indicate if it's an atom or a bond - this could eventually support bond selections
                    return
                }
                
                tappedNode?.setHighlighted()

                let selectedMaterial = SCNMaterial()
//                selectedMaterial.diffuse.contents = UIColor.red
                let color = atomRadii[tappedNode?.name! ?? "H"]?.color
                selectedMaterial.diffuse.contents = color

                if selectedAtoms.count < 4 {
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

                    selectedAtoms.append(tappedNode!)

                    if selectedAtoms.count == 1 {
                        firstAtomNameLabel.text = "Name: \(tappedNode?.name! ?? "none")"

                        showFirstAtomInfo()
                        doneSelectingButton.isHidden = false
                    }
                    else if selectedAtoms.count == 2 {
                        secondAtomNameLabel.text = "Name: \(tappedNode?.name! ?? "none")"

                        showSecondAtomInfo()
                        doneSelectingButton.isHidden = false

                        distanceLabel.text = "Distance: \(calculateDistance())"
                        distanceLabel.isHidden = false
                    }
                }
            }
        }
    }
    
    @IBAction func doneSelectingButtonPressed(_ sender: Any) {
        hideAtomInfo()
        lockCameraButton.isHidden = true
        
        for atom in atomNodes {                             // Resets atom color
            let color = atomRadii[atom.name!]?.color
            let originalMaterial = SCNMaterial()
            originalMaterial.diffuse.contents = color
            atom.geometry?.firstMaterial = originalMaterial
            atom.clearHighlighted()
        }
        
        selectedAtoms.removeAll()
    }
    
    func hideAtomInfo() {
        firstAtomNameLabel.isHidden = true
        
        secondAtomNameLabel.isHidden = true
        
        thirdAtomNameLabel.isHidden = true
        
        fourthAtomNameLabel.isHidden = true
        
        distanceLabel.isHidden = true
        
        doneSelectingButton.isHidden = true
    }
    
    func showAtomInfo() {
        showFirstAtomInfo()
        showSecondAtomInfo()
        
        doneSelectingButton.isHidden = false
    }
    
    func showFirstAtomInfo() {
        firstAtomNameLabel.isHidden = false
    }
    
    func showSecondAtomInfo() {
        secondAtomNameLabel.isHidden = false
    }
    
    @objc func updateLabels() {
        distanceLabel.text = "Distance: \(calculateDistance())"
        stepLabel.text = "Step: \(step) / \(atoms[0].actions.count - 1)"
        
        if(selectedAtoms.count == 1) {
            lockCameraButton.isHidden = false
        }
        else {
            lockCameraButton.isHidden = true
        }
        
        if(selectedAtoms.count == 3) {
            thirdAtomNameLabel.isHidden = false
            thirdAtomNameLabel.text = selectedAtoms[2].name
            let angle = (calculateAngle3() * 180) / .pi
            print(angle)
            distanceLabel.text = "Angle: \(angle)"
        }
        
        if(selectedAtoms.count == 4) {
            fourthAtomNameLabel.isHidden = false
            fourthAtomNameLabel.text = selectedAtoms[3].name
            distanceLabel.text = "Dihedral Angle: "
        }
        
        if((lockNode.count != 0) && (selectedAtoms.count != 0)) {
            if lockNode[0] == selectedAtoms[0] {
                lockCameraButton.isEnabled = false
            }
            else {
                lockCameraButton.isEnabled = true
            }
        }
    }
    
    func calculateDistance() -> Float {
        guard selectedAtoms.count == 2 else { return 0 } // FIXME: This might need to be a little more robust
        
        let node1 = selectedAtoms[0]
        let node2 = selectedAtoms[1]
        
        return sqrt(pow((node1.position.x - node2.position.x),2) + pow((node1.position.y - node2.position.y), 2) + pow((node1.position.z - node2.position.z), 2))
    }
    
    func calculateDistance(node1: SCNNode, node2: SCNNode) -> Float {
        return sqrt(pow((node1.position.x - node2.position.x),2) + pow((node1.position.y - node2.position.y), 2) + pow((node1.position.z - node2.position.z), 2))
    }
    
    func averagePosition(node1: SCNNode, node2: SCNNode) -> SCNVector3 {
        return SCNVector3((node1.position.x + node2.position.x) / 2, (node1.position.y + node2.position.y) / 2, (node1.position.z + node2.position.z) / 2)
    }
    
    func calculateAngle3() -> Float {
        let x1 = selectedAtoms[0].position.x
        let y1 = selectedAtoms[0].position.y
        let z1 = selectedAtoms[0].position.z
        
        let x2 = selectedAtoms[1].position.x
        let y2 = selectedAtoms[1].position.y
        let z2 = selectedAtoms[1].position.z
        
        let x3 = selectedAtoms[2].position.x
        let y3 = selectedAtoms[2].position.y
        let z3 = selectedAtoms[2].position.z
        
        let v1 = SCNVector3(x1 - x2, y1 - y2, z1 - z2)
        let v2 = SCNVector3(x3 - x2, y3 - y2, z3 - z2)
        
        
        let v1mag = sqrt(v1.x * v1.x + v1.y * v1.y + v1.z * v1.z)
        let v1norm = SCNVector3(v1.x / v1mag, v1.y / v1mag, v1.z / v1mag)
         
        let v2mag = sqrt(v2.x * v2.x + v2.y * v2.y + v2.z * v2.z)
        let v2norm = SCNVector3(v2.x / v2mag, v2.y / v2mag, v2.z / v2mag)
         
        let res = v1norm.x * v2norm.x + v1norm.y * v2norm.y + v1norm.z * v2norm.z
        
        let angle = acos(res)
        
        return angle
    }
    
    
    
//    func calculateAngle(node1: SCNNode, node2: SCNNode) -> Float {
//        let numerator = (node1.position.x * node2.position.x) + (node1.position.y * node1.position.y) + (node1.position.z * node2.position.z)
//        let denominator = sqrt(pow(node1.position.x, 2) + pow(node1.position.y, 2) + pow(node1.position.z, 2)) * sqrt(pow(node2.position.x, 2) + pow(node2.position.y, 2) + pow(node2.position.z, 2))
//        return acos( numerator / denominator )
//    }
    
    @IBAction func reverseButtonTapped(_ sender: Any) {
        isReverse = !isReverse
        
        let button = sender as! UIButton
        
        if isReverse {
            button.setImage(UIImage(systemName: "forward.fill"), for: .normal)
        }
        else {
            button.setImage(UIImage(systemName: "backward.fill"), for: .normal)
        }
    }
    
    @IBAction func skipAheadButtonTapped(_ sender: Any) {
        switch sender as! NSObject {
        case stepAheadButton:
            if step == atoms[0].actions.count - 1 {
                step = 0
            }
            else {
                step += 1
            }
        case skipAheadButton:
            if step + 10 > atoms[0].actions.count - 1 {
                step = 10 - (atoms[0].actions.count - 1 - step)
            }
            else {
                step += 10
            }
        case skipToEndButton:
            step = atoms[0].actions.count - 1
        case stepBackButton:
            if step == 0 {
                step = atoms[0].actions.count - 1
            }
            else {
                step -= 1
            }
        case skipBackButton:
            if step - 10 < 0 {
                step = atoms[0].actions.count - 10 + step
            }
            else {
                step -= 10
            }
        case skipToBeginningButton:
            step = 0
        default:
            print("Error")
        }
        
        updateLabels()
    }
    
    func getCameraPosition(maxX: Double, maxY: Double, maxZ: Double) -> Float {
        let finalX = 3 * maxX + 11
        let finalY = 3 * maxY + 11
        let finalZ = maxZ + 11
        
        return Float(max(finalX, finalY, finalZ))
    }
    
    @IBAction func loopButtonPressed(_ sender: Any) {
        isLooping.toggle()
        if isLooping {
            loopButton.tintColor = UIColor.systemBlue
        }
        else {
            loopButton.tintColor = gray
        }
    }
    
    @IBAction func buttonTouchDown(_ sender: UIButton) {
        UIView.animate(withDuration: 0.25) {
            sender.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        }
    }
    
    @IBAction func buttonTouchUp(_ sender: UIButton) {
        UIView.animate(withDuration: 0.25) {
            sender.transform = CGAffineTransform.identity
        }
    }
    
    func makeBond(atom1: SCNNode, atom2: SCNNode) {
        let x1 = atom1.position.x
        let x2 = atom2.position.x
        
        let y1 = atom1.position.y
        let y2 = atom2.position.y
        
        let z1 = atom1.position.z
        let z2 = atom2.position.z
        
        let distance =  sqrtf( (x2-x1) * (x2-x1) +
                                (y2-y1) * (y2-y1) +
                                (z2-z1) * (z2-z1) )
        
        let baseGeometry = SCNCylinder(radius: 0.15, height: CGFloat(distance))
        baseGeometry.firstMaterial?.diffuse.contents = UIColor.lightGray // FIXME: Does this have anything to do with the shininess related crashes?
        baseGeometry.firstMaterial?.transparency = 0.5 // FIXME: Also appears to be causing crashes 
        
        let node = SCNNode(geometry: baseGeometry)
        node.position = SCNVector3(x: (x1 + x2) / 2,
                                   y: (y1 + y2) / 2,
                                   z: (z1 + z2) / 2)
        
        node.eulerAngles = SCNVector3(Float.pi / 2,
                                      acos((z2-z1)/distance),
                                      atan2((y2-y1),(x2-x1)))
        
        bondNodes.append(node)
        scene.rootNode.addChildNode(node)
    }
    
    func isJoinable(atom: SCNAtom) -> Bool {
        if atom.bondedTo.count < maxBonds[atom.name] ?? 0 {
            return true
        }
        else {
            return false
        }
    }
    
    func updateBonds() {
        
        for bond in bondNodes {
            bond.removeFromParentNode()
        }
        
        bondNodes.removeAll()
        
        /*
         for atom in atomNodes
            for atom2 in atomNodes
                calculateDistance
                if distance < 0.8
                    add to VECTOR
            sort vector
            for i in atom1.getMaxBonds
                bond to atom2
         */
        
        // For partial bonds, you could run this same algorithm but with a different value than 0.8
        
        var j = 0
        for atom in atomNodes {
            var vect: [Double : SCNNode] = [:]
            for atom2 in atomNodes {
                let radius1 = Float(atomRadii[atom.name!]?.covalentRadius ?? 0.0)
                let radius2 = Float(atomRadii[atom2.name!]?.covalentRadius ?? 0.0)
                let dist = (calculateDistance(node1: atom, node2: atom2) - radius1 - radius2)
                if (dist) < 0.8 && atom != atom2 && atom2.name != "H" {
                    vect[Double(dist)] = atom2
                }
            }
            let sortedKeys = Array(vect.keys.sorted(by: <))
            for i in 0...(maxBonds[atom.name ?? "He"] ?? 0) {
                if i < sortedKeys.count && isJoinable(atom: atoms[i]) { // FIXME: Also need to make sure that atom2 isn't bonded out
                        // Could I do this by letting an atom override if it's already bonded to something else but should only be bonded to one? Like if a H has been bonded to by O, but the H should only be bonding to the C right next to it, it could erase that bond and just make the other one
                    // On the other hand, could I just sort the array of atoms by the number bonds it can make, then run the same algorithm?
                        // FIXME: How to get the right atom for the isJoinable call?
                    makeBond(atom1: atom, atom2: vect[sortedKeys[i]]!)
                    
                }
                
            }
            
            j += 1
        }
    }
    
    @IBAction func lockCameraButtonPressed(_ sender: Any) {
//        cameraNode.look(at: selectedAtoms[0].position)
        let lookConstraint = SCNLookAtConstraint(target: selectedAtoms[0])
        sceneView.pointOfView?.constraints = [lookConstraint]
        if (lockNode.count == 0) {
            lockNode.append(selectedAtoms[0])
        }
        else {
            lockNode[0] = selectedAtoms[0]
        }
    }
    
    func updateRadii() {
        
        
        for atom in atomNodes {
            var radius: CGFloat
            switch selectedAtomRadius {
            case 0:
                radius = CGFloat(atomRadii[atom.name!]?.atomicRadius ?? 0.5)
            case 1:
                radius = CGFloat(atomRadii[atom.name!]?.ionicRadius ?? 0.5)
            case 2:
                radius = CGFloat(atomRadii[atom.name!]?.covalentRadius ?? 0.5)
            case 3:
                radius = CGFloat(atomRadii[atom.name!]?.vanDerWallsRadius ?? 0.5)
            default:
                radius = 0.5
            }
//            let radius = atomRadii[atom.name!]?.vanDerWallsRadius ?? 0.5
            let color = atomRadii[atom.name!]?.color
            let newGeometry = SCNSphere(radius: CGFloat(radius))
            let newMaterial = SCNMaterial()
            newMaterial.diffuse.contents = color
            newGeometry.materials = [newMaterial]
            atom.geometry = newGeometry
        }
    }
    
    @IBAction func unwindToViewer(unwindSegue: UIStoryboardSegue) {}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "optionsMenu" {
            let destVC = segue.destination as! OptionsViewController
            destVC.index = selectedAtomRadius
        }
    }
    
    @IBAction func TSButtonPressed(_ sender: Any) {
        step = 1000
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        timer.invalidate()
    }
    
    deinit {
        atoms.removeAll()
        atomNodes.removeAll()
        selectedAtoms.removeAll()
        bondsUnused.removeAll()
        bondNodes.removeAll()
    }
}

extension SCNNode {
    func setHighlighted( _ highlighted : Bool = true, _ highlightedBitMask : Int = 2 ) {
        categoryBitMask = highlightedBitMask
        for child in self.childNodes {
            child.setHighlighted()
        }
    }
    
    func clearHighlighted() {
        categoryBitMask = 1
        for child in self.childNodes {
            child.clearHighlighted()
        }
    }
}

//extension SCNGeometry {
//    
//    class func cylinderLine(from: SCNVector3,
//                            to: SCNVector3,
//                            segments: Int) -> SCNNode {
//        
//        let x1 = from.x
//        let x2 = to.x
//        
//        let y1 = from.y
//        let y2 = to.y
//        
//        let z1 = from.z
//        let z2 = to.z
//        
//        let distance =  sqrtf( (x2-x1) * (x2-x1) +
//                                (y2-y1) * (y2-y1) +
//                                (z2-z1) * (z2-z1) )
//        
//        let cylinder = SCNCylinder(radius: 0.15,
//                                   height: CGFloat(distance))
//        
//        cylinder.radialSegmentCount = segments
//        
//        cylinder.firstMaterial?.diffuse.contents = UIColor.red
//        
//        let lineNode = SCNNode(geometry: cylinder)
//        
//        lineNode.position = SCNVector3(x: (from.x + to.x) / 2,
//                                       y: (from.y + to.y) / 2,
//                                       z: (from.z + to.z) / 2)
//        
//        lineNode.eulerAngles = SCNVector3(Float.pi / 2,
//                                          acos((to.z-from.z)/distance),
//                                          atan2((to.y-from.y),(to.x-from.x)))
//        
//        return lineNode
//    }
//}

