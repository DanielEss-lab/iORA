//
//  Lighting.swift
//  iORA
//
//  Created by Jeremiah Brown on 8/04/22.
//

import Foundation
import SceneKit

class Lighting {
    func setLighting(type: String) -> SCNLight
    {
        let tempNode = SCNNode()
        tempNode.light = SCNLight()
        
        tempNode.light?.color = UIColor.darkGray
        tempNode.position = SCNVector3(0.0, 0.0, -20.0)
        tempNode.light?.type = SCNLight.LightType(rawValue: type)
        
        if (type == "ambient")
        {
            tempNode.light?.intensity = 1000
        }
        
        return SCNLight()
    }
}
