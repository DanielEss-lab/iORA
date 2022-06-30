//
//  ViewController.swift
//  iORA
//
//  Created by Gabriel Reed on 1/4/21.
//

import UIKit
import SceneKit
import SwiftUI

let scene = SCNScene()

var engine = Engine()
let defaults = UserDefaults.standard

let distMult = 1

let masterAtom = SCNNode()
let masterBond = SCNNode()

var sceneAtoms: [SCNNode] = []
var atomActions: [SCNNode: AtomInfo] = [:]
var sceneBonds: [SCNNode] = []

var stepDuration = defaults.double(forKey: "STEP_DURATION") // fps = 1 / stepDuration
var step = 0
let scaleFactor = 1.0
var speedSetting = 0;

var maxX = 0.0
var maxY = 0.0
var maxZ = 0.0

class ViewController: UIViewController {
    
    @IBOutlet weak var sceneView: SCNView!
    let cameraNode = SCNNode()
    var timer = Timer()
    var isLooping = true;

    @IBOutlet weak var stepSlider: UISlider!
    @IBOutlet weak var stepAheadButton: UIButton!
    @IBOutlet weak var skipAheadButton: UIButton!
    @IBOutlet weak var skipToEndButton: UIButton!
    @IBOutlet weak var stepBackButton: UIButton!
    @IBOutlet weak var skipBackButton: UIButton!
    @IBOutlet weak var skipToBeginningButton: UIButton!
    //@IBOutlet weak var stepLabel: UILabel!
    @IBOutlet weak var loopButton: UIButton!
    @IBOutlet weak var speedSlider: UISlider!
    //@IBOutlet weak var lockCameraButton: UIButton!
    
    var infoView = UIHostingController(rootView: InfoView(atoms:["-"], labelName: "Distance", labelData: "-"))
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if !sceneView.scene!.isPaused { // This is very necessary. Without it everything breaks
            sceneView.scene!.isPaused = true
        }
        
        for atom in sceneAtoms {
            atom.removeFromParentNode()
        }
        for bond in sceneBonds {
            bond.removeFromParentNode()
        }
        
        scene.rootNode.enumerateChildNodes { (node, stop) in
            node.removeFromParentNode()
        }
        sceneAtoms.removeAll()
        sceneBonds.removeAll()
        selectedAtoms.removeAll()
        step = 0
        timer.invalidate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaultInit = Defaults() //It might be better to put this in AppDelegate or even SceneDelegate
        defaultInit.setUp()
        
        loopButton?.backgroundColor = UIColor.systemGray
        
        engine.initialDraw();
        sceneSetup()
        
        stepSlider.maximumValue = Float(states.count - 1)
        
        weak var pass = self
        timer = Timer.scheduledTimer(timeInterval: stepDuration, target: pass as Any, selector: #selector(animate), userInfo: nil, repeats: true)
        
        addChild(infoView)
        view.addSubview(infoView.view)
        infoView.view.translatesAutoresizingMaskIntoConstraints = false
        infoView.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = false
        infoView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        infoView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        infoView.view.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        infoView.view.removeFromSuperview()
        infoView.view.backgroundColor = UIColor.white.withAlphaComponent(0.0)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap(rec:)))
        sceneView.addGestureRecognizer(tap)
    }
    
    
    func sceneSetup() {
        stepSlider.maximumValue = Float(atomActions[sceneAtoms[0]]?.actions.count ?? 1)
        
        scene.isPaused = true // FIXME: Delete
        
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 0, z: getCameraPosition(maxX: maxX, maxY: maxY, maxZ: maxZ))
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 10)
        scene.rootNode.addChildNode(cameraNode)
        
        // Scene light
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .omni
        lightNode.position = SCNVector3(x: -40, y: 40, z: 35)
        //lightNode.light?.intensity *= 0.3
        scene.rootNode.addChildNode(lightNode)
        
        // Ambient light
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light?.type = .ambient
        ambientLightNode.light?.color = UIColor.darkGray
        ambientLightNode.position = SCNVector3(0.0, 0.0, -20.0)
        ambientLightNode.light?.intensity = 1200 // Default 3500
        scene.rootNode.addChildNode(ambientLightNode)
        
        sceneView.backgroundColor = UIColor(red: 0.09, green: 0.28, blue: 0.59, alpha: 1.00) // Dark blue
        sceneView.allowsCameraControl = true
        
        scene.rootNode.addChildNode(masterAtom)
        scene.rootNode.addChildNode(masterBond)
        scene.rootNode.addChildNode(masterLine)
        
        sceneView.scene = scene
    }
    
    //FIXME: Not currently functioning
    @objc func animate() {
        if (!scene.isPaused) {
            if (step < (engine.getStates().count) - 1) {
                engine.drawState(stateNum: step)
                updateLines()
                step += 1
            }
            else if (isLooping) {
                step = 0
            }
            else {
                sceneView.scene?.isPaused = true
            }
        }
        stepSlider.value = Float(step)
    }
    
    //FIXME: Not currently functioning
    @IBAction func stepSliderChanged(_ sender: Any) {
        step = Int(stepSlider.value)
        if (scene.isPaused) {
            engine.drawState(stateNum: step)
            updateLines()
        }
    }
    
    @IBAction func playPauseButtonTapped(_ sender: Any) {
        let playBtn = sender as! UIButton
        
        sceneView.scene?.isPaused = !(sceneView.scene!.isPaused)
        
        if sceneView.scene!.isPaused {
            playBtn.setImage(UIImage(systemName: "play.fill"), for: .normal)
        }
        else {
            playBtn.setImage(UIImage(systemName: "pause.fill"), for: .normal)
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
    
    @IBAction func loopButtonPressed(_ sender: Any) {
        let loopBtn = sender as! UIButton
        isLooping.toggle()
        if isLooping {
            loopBtn.tintColor = UIColor.systemBlue
        }
        else {
            loopBtn.tintColor = UIColor.systemGray
        }
    }
    
    @IBAction func skipToEndButtonTapped(_ sender: Any) {
        //let skipBtn = sender as! UIButton
        step = states.count
        scene.isPaused = true
    }
    
    @IBAction func skipToBeginningButtonTapped(_ sender: Any) {
        step = 0
    }
    
    func getCameraPosition(maxX: Double, maxY: Double, maxZ: Double) -> Float {
        let finalX = 3 * maxX + 11
        let finalY = 3 * maxY + 11
        let finalZ = maxZ + 11
        
        return Float(max(finalX, finalY, finalZ))
    }
    
    @IBAction func speedButtonTapped(_ sender: Any) {
        let speedButton = sender as! UIButton
        
        if speedSetting >= 6
        {
            speedSetting = 0
        }
        else
        {
            speedSetting+=1
        }
        
        if speedSetting == 0 {
            speedButton.setTitle("1x", for: .normal)
            stepDuration = defaults.double(forKey: "STEP_DURATION")
        }
        else if speedSetting == 1 {
            speedButton.setTitle("2x", for: .normal)
            stepDuration = defaults.double(forKey: "STEP_DURATION") * 0.5
        }
        else if speedSetting == 2 {
            speedButton.setTitle("3x", for: .normal)
            stepDuration = defaults.double(forKey: "STEP_DURATION") * 0.33
        }
        else if speedSetting == 3 {
            speedButton.setTitle("4x", for: .normal)
            stepDuration = defaults.double(forKey: "STEP_DURATION") * 0.25
        }
        else if speedSetting == 4 {
            speedButton.setTitle("10x", for: .normal)
            stepDuration = defaults.double(forKey: "STEP_DURATION") * 0.1
        }
        else if speedSetting == 5 {
            speedButton.setTitle("0.5x", for: .normal)
            stepDuration = defaults.double(forKey: "STEP_DURATION") * 2
        }
        else if speedSetting == 6 {
            speedButton.setTitle("0.25x", for: .normal)
            stepDuration = defaults.double(forKey: "STEP_DURATION") * 4
        }
        timer.invalidate()
        timer = Timer.scheduledTimer(timeInterval: stepDuration, target: self as Any, selector: #selector(animate), userInfo: nil, repeats: true)
    }
    
    @IBAction func transitionStateButtonTapped(_ sender: Any)
    {
        step = states.count / 2
        //step = globalTransitionState
        engine.drawState(stateNum: step)
        updateLines()
    }

    //not currently used
    func sortAtoms() {
        sceneAtoms = sceneAtoms.sorted(by: { $0.name ?? "He" < $1.name ?? "He" })
    }
    
}

struct AtomInfo {
    var positions: [SCNVector3]
    var actions: [SCNAction]
}
