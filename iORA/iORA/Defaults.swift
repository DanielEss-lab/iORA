//
//  Defaults.swift
//  iORA
//
//  Created by Jeremiah on 6/27/22.
//

import Foundation
import UIKit

class Defaults {
    let defaults = UserDefaults.standard
    
    func setUp() {
        if defaults.bool(forKey: "SET_UP_PERFORMED_2") == false {
            defaults.set(0.1, forKey: "STEP_DURATION")
            //defaults.set(1.0, forKey: "DISTANCE_MULTIPLIER")
            defaults.set(1.0, forKey: "SCALE_FACTOR")
            defaults.set(0.06, forKey: "BOND_RADIUS")
            defaults.set(LightSources.directional.rawValue, forKey: "LIGHT_SOURCE")
            defaults.backgroundColor = UIColor(red: 0.09, green: 0.28, blue: 0.59, alpha: 1.00)
            defaults.set(false, forKey: "ARE_BONDS_COLORED")
            defaults.set(false, forKey: "ARE_BONDS_TRANSPARENT")
            defaults.set(1.0, forKey: "ATOM_RADIUS_MULTIPLIER")
            
            //..
            defaults.set(true, forKey: "SET_UP_PERFORMED_2")
        }
    }
}

/* This code is StackOverflow and is used to allow storing colors inside UserDefaults. https://stackoverflow.com/questions/34366171/how-do-i-save-a-uicolor-with-userdefaults
 */
extension Numeric {
    var data: Data {
        var bytes = self
        return Data(bytes: &bytes, count: MemoryLayout<Self>.size)
    }
}

extension Data {
    func object<T>() -> T { withUnsafeBytes{$0.load(as: T.self)} }
    var color: UIColor { .init(data: self) }
}

extension UIColor {
    convenience init(data: Data) {
        let size = MemoryLayout<CGFloat>.size
        self.init(red:   data.subdata(in: size*0..<size*1).object(),
                  green: data.subdata(in: size*1..<size*2).object(),
                  blue:  data.subdata(in: size*2..<size*3).object(),
                  alpha: data.subdata(in: size*3..<size*4).object())
    }
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat)? {
        var (red, green, blue, alpha): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
        return getRed(&red, green: &green, blue: &blue, alpha: &alpha) ?
        (red, green, blue, alpha) : nil
    }
    var data: Data? {
        guard let rgba = rgba else { return nil }
        return rgba.red.data + rgba.green.data + rgba.blue.data + rgba.alpha.data
    }
}

extension UserDefaults {
    func set(_ color: UIColor?, forKey defaultName: String) {
        guard let data = color?.data else {
            removeObject(forKey: defaultName)
            return
        }
        set(data, forKey: defaultName)
    }
    func color(forKey defaultName: String) -> UIColor? {
        data(forKey: defaultName)?.color
    }
}

extension UserDefaults {
    var backgroundColor: UIColor? {
        get { color(forKey: "BG_COLOR") }
        set { set(newValue, forKey: "BG_COLOR") }
    }
}
