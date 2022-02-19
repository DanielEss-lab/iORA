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

let distMult = 1

let masterAtom = SCNNode()
let masterBond = SCNNode()

var sceneAtoms: [SCNNode] = []
var atomActions: [SCNNode: AtomInfo] = [:]
var sceneBonds: [SCNNode] = []

var stepDuration = 0.02
var step = 0
let scaleFactor = 1.0

var maxX = 0.0
var maxY = 0.0
var maxZ = 0.0

class ViewController: UIViewController {
    
    @IBOutlet weak var sceneView: SCNView!
    let cameraNode = SCNNode()
    var timer = Timer()

    @IBOutlet weak var stepSlider: UISlider!
    
    var infoView = UIHostingController(rootView: InfoView(atoms:["-"], labelName: "Distance", labelData: "-"))
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        scene.rootNode.enumerateChildNodes { (node, stop) in
            node.removeFromParentNode()
        }
        selectedAtoms.removeAll()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        engine.initialDraw();
        sceneSetup()
        
        // Animation timer 
//        if atomActions[sceneAtoms[0]]?.actions.count ?? 0 > 0 {
//            weak var pass = self
//            timer = Timer.scheduledTimer(timeInterval: stepDuration, target: pass as Any, selector: #selector(animate), userInfo: nil, repeats: true)
//        }
        //FIXME: This will break some things
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
        if (!scene.isPaused)
        {
            if (step < (engine.getStates().count) - 1)
            {
                step += 1
                engine.drawState(stateNum: step)
                updateLines()
            }
            else
            {
                step = 0
            }
        }
        
        stepSlider.value = Float(step)
    }
    
    //FIXME: Not currently functioning
    @IBAction func stepSliderChanged(_ sender: Any) {
        step = Int(stepSlider.value)
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
    
    func getCameraPosition(maxX: Double, maxY: Double, maxZ: Double) -> Float {
        let finalX = 3 * maxX + 11
        let finalY = 3 * maxY + 11
        let finalZ = maxZ + 11
        
        return Float(max(finalX, finalY, finalZ))
    }

    //FIXME: Not currently functioning
    func sortAtoms() {
        sceneAtoms = sceneAtoms.sorted(by: { $0.name ?? "He" < $1.name ?? "He" })
        
        // Could I make it so that you could have a lookup hash map that will be sorted, then just run them off of that?
    }
    
}

struct AtomInfo {
    var positions: [SCNVector3]
    var actions: [SCNAction]
}
