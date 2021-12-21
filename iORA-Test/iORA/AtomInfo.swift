//
//  AtomInfo.swift
//  iORA
//
//  Created by Gabriel Reed on 1/5/21.
//

import Foundation
import SceneKit

let darkRed = UIColor(hue: 0.05, saturation: 1.00, brightness: 0.50, alpha: 1.0)
let white = UIColor.white
let cyan = UIColor.cyan
let violet = UIColor.purple
let darkGreen = UIColor.systemGreen
let black = UIColor.black
let blue = UIColor.blue
let red = UIColor.red
let green = UIColor.green
let pink = UIColor.systemPink
let beige = UIColor(displayP3Red: 0.802, green: 0.779, blue: 0.721, alpha: 1.0)
let gray = UIColor.lightGray
let orange = UIColor.orange // FIXME: Put in a different color
let yellow = UIColor.yellow // FIXME: Put in a different color
let darkOrange = UIColor.orange // FIXME: Put in a different color
let darkViolet = UIColor.purple // FIXME: Put in a different color

struct AtomMeasurement {
    let name: String
    let atomicRadius: Double?
    let ionicRadius: Double?
    let covalentRadius: Double?
    let vanDerWallsRadius: Double?
    let crystalRadius: Double?
    let customRadius: Double?
    let color: UIColor
}

let H = AtomMeasurement(name: "H", atomicRadius: 0.53, ionicRadius: 0.25, covalentRadius: 0.37, vanDerWallsRadius: 1.2, crystalRadius: 0.1, customRadius: 0.3, color: white)
let He = AtomMeasurement(name: "He", atomicRadius: 0.31, ionicRadius: 0.31, covalentRadius: 0.32, vanDerWallsRadius: 1.4, crystalRadius: nil, customRadius: 0.31, color: cyan)
let Li = AtomMeasurement(name: "Li", atomicRadius: 1.67, ionicRadius: 1.45, covalentRadius: 1.34, vanDerWallsRadius: 1.82, crystalRadius: 0.9, customRadius: 1.45, color: violet)
let Be = AtomMeasurement(name: "Be", atomicRadius: 1.12, ionicRadius: 1.05, covalentRadius: 0.9, vanDerWallsRadius: nil, crystalRadius: 0.41, customRadius: 1.05, color: darkGreen)
let B = AtomMeasurement(name: "B", atomicRadius: 0.87, ionicRadius: 0.85, covalentRadius: 0.82, vanDerWallsRadius: nil, crystalRadius: 0.25, customRadius: 0.85, color: beige)
let C = AtomMeasurement(name: "C", atomicRadius: 0.67, ionicRadius: 0.7, covalentRadius: 0.77, vanDerWallsRadius: 1.7, crystalRadius: 0.29, customRadius: 0.55, color: black)
let N = AtomMeasurement(name: "N", atomicRadius: 0.56, ionicRadius: 0.65, covalentRadius: 0.75, vanDerWallsRadius: 1.55, crystalRadius: 0.3, customRadius: 0.65, color: blue)
let O = AtomMeasurement(name: "O", atomicRadius: 0.48, ionicRadius: 0.6, covalentRadius: 0.73, vanDerWallsRadius: 1.52, crystalRadius: 1.21, customRadius: 0.6, color: red)
let F = AtomMeasurement(name: "F", atomicRadius: 0.42, ionicRadius: 0.5, covalentRadius: 0.71, vanDerWallsRadius: 1.47, crystalRadius: 1.19, customRadius: 0.5, color: green)
let Ne = AtomMeasurement(name: "Ne", atomicRadius: 0.38, ionicRadius: 0.38, covalentRadius: 0.69, vanDerWallsRadius: 1.54, crystalRadius: nil, customRadius: 0.38, color: cyan)
let Na = AtomMeasurement(name: "Na", atomicRadius: 1.9, ionicRadius: 1.8, covalentRadius: 1.54, vanDerWallsRadius: 2.27, crystalRadius: 1.16, customRadius: 1.8, color: violet)
let Mg = AtomMeasurement(name: "Mg", atomicRadius: 1.45, ionicRadius: 1.5, covalentRadius: 1.3, vanDerWallsRadius: 1.73, crystalRadius: 0.86, customRadius: 1.5, color: darkGreen)
let Al = AtomMeasurement(name: "Al", atomicRadius: 1.18, ionicRadius: 1.25, covalentRadius: 1.18, vanDerWallsRadius: nil, crystalRadius: 0.53, customRadius: 1.25, color: beige)
let Si = AtomMeasurement(name: "Si", atomicRadius: 1.11, ionicRadius: 1.1, covalentRadius: 1.11, vanDerWallsRadius: 2.1, crystalRadius: 0.4, customRadius: 1.1, color: beige)
let P = AtomMeasurement(name: "P", atomicRadius: 0.98, ionicRadius: 1, covalentRadius: 1.06, vanDerWallsRadius: 1.8, crystalRadius: 0.31, customRadius: 1, color: orange)
let S = AtomMeasurement(name: "S", atomicRadius: 0.88, ionicRadius: 1, covalentRadius: 1.02, vanDerWallsRadius: 1.8, crystalRadius: 0.43, customRadius: 1, color: yellow)
let Cl = AtomMeasurement(name: "Cl", atomicRadius: 0.79, ionicRadius: 1, covalentRadius: 0.99, vanDerWallsRadius: 1.75, crystalRadius: 1.67, customRadius: 0.7, color: green)
let Ar = AtomMeasurement(name: "Ar", atomicRadius: 0.71, ionicRadius: 0.71, covalentRadius: 0.97, vanDerWallsRadius: 1.88, crystalRadius: nil, customRadius: 0.71, color: cyan)
let K = AtomMeasurement(name: "K", atomicRadius: 2.43, ionicRadius: 2.2, covalentRadius: 1.96, vanDerWallsRadius: 2.75, crystalRadius: 1.52, customRadius: 2.2, color: violet)
let Ca = AtomMeasurement(name: "Ca", atomicRadius: 1.94, ionicRadius: 1.8, covalentRadius: 1.74, vanDerWallsRadius: nil, crystalRadius: 1.14, customRadius: 1.8, color: darkGreen)
let Sc = AtomMeasurement(name: "Sc", atomicRadius: 1.84, ionicRadius: 1.6, covalentRadius: 1.44, vanDerWallsRadius: nil, crystalRadius: 0.89, customRadius: nil, color: beige)
let Ti = AtomMeasurement(name: "Ti", atomicRadius: 1.76, ionicRadius: 1.4, covalentRadius: 1.36, vanDerWallsRadius: nil, crystalRadius: 0.75, customRadius: nil, color: gray)
let V = AtomMeasurement(name: "V", atomicRadius: 1.71, ionicRadius: 1.35, covalentRadius: 1.25, vanDerWallsRadius: nil, crystalRadius: 0.68, customRadius: nil, color: beige)
let Cr = AtomMeasurement(name: "Cr", atomicRadius: 1.66, ionicRadius: 1.4, covalentRadius: 1.27, vanDerWallsRadius: nil, crystalRadius: 0.76, customRadius: nil, color: beige)
let Mn = AtomMeasurement(name: "Mn", atomicRadius: 1.61, ionicRadius: 1.4, covalentRadius: 1.39, vanDerWallsRadius: nil, crystalRadius: 0.81, customRadius: nil, color: beige)
let Fe = AtomMeasurement(name: "Fe", atomicRadius: 1.56, ionicRadius: 1.4, covalentRadius: 1.25, vanDerWallsRadius: nil, crystalRadius: 0.69, customRadius: nil, color: darkOrange)
let Co = AtomMeasurement(name: "Co", atomicRadius: 1.52, ionicRadius: 1.35, covalentRadius: 1.26, vanDerWallsRadius: nil, crystalRadius: 0.54, customRadius: nil, color: beige)
let Ni = AtomMeasurement(name: "Ni", atomicRadius: 1.49, ionicRadius: 1.35, covalentRadius: 1.21, vanDerWallsRadius: 1.63, crystalRadius: 0.7, customRadius: nil, color: beige)
let Cu = AtomMeasurement(name: "Cu", atomicRadius: 1.45, ionicRadius: 1.35, covalentRadius: 1.38, vanDerWallsRadius: 1.4, crystalRadius: 0.71, customRadius: nil, color: beige)
let Zn = AtomMeasurement(name: "Zn", atomicRadius: 1.42, ionicRadius: 1.35, covalentRadius: 1.31, vanDerWallsRadius: 1.39, crystalRadius: 0.74, customRadius: nil, color: beige)
let Ga = AtomMeasurement(name: "Ga", atomicRadius: 1.36, ionicRadius: 1.3, covalentRadius: 1.26, vanDerWallsRadius: 1.87, crystalRadius: 0.76, customRadius: nil, color: beige)
let Ge = AtomMeasurement(name: "Ge", atomicRadius: 1.25, ionicRadius: 1.25, covalentRadius: 1.22, vanDerWallsRadius: nil, crystalRadius: 0.53, customRadius: nil, color: beige)
let As = AtomMeasurement(name: "As", atomicRadius: 1.14, ionicRadius: 1.15, covalentRadius: 1.19, vanDerWallsRadius: 1.85, crystalRadius: 0.72, customRadius: nil, color: beige)
let Se = AtomMeasurement(name: "Se", atomicRadius: 1.03, ionicRadius: 1.15, covalentRadius: 1.16, vanDerWallsRadius: 1.9, crystalRadius: 0.56, customRadius: nil, color: beige)
let Br = AtomMeasurement(name: "Br", atomicRadius: 0.94, ionicRadius: 1.15, covalentRadius: 1.14, vanDerWallsRadius: 1.85, crystalRadius: 1.82, customRadius: nil, color: darkRed)
let Kr = AtomMeasurement(name: "Kr", atomicRadius: 0.88, ionicRadius: 0.88, covalentRadius: 1.1, vanDerWallsRadius: 2.02, crystalRadius: nil, customRadius: nil, color: cyan)
let Rb = AtomMeasurement(name: "Rb", atomicRadius: 2.65, ionicRadius: 2.35, covalentRadius: 2.11, vanDerWallsRadius: nil, crystalRadius: 1.66, customRadius: nil, color: violet)
let Sr = AtomMeasurement(name: "Sr", atomicRadius: 2.19, ionicRadius: 2, covalentRadius: 1.92, vanDerWallsRadius: nil, crystalRadius: 1.32, customRadius: nil, color: darkGreen)
let Y = AtomMeasurement(name: "Y", atomicRadius: 2.12, ionicRadius: 1.85, covalentRadius: 1.62, vanDerWallsRadius: nil, crystalRadius: 1.04, customRadius: nil, color: beige)
let Zr = AtomMeasurement(name: "Zr", atomicRadius: 2.06, ionicRadius: 1.55, covalentRadius: 1.48, vanDerWallsRadius: nil, crystalRadius: 0.86, customRadius: nil, color: beige)
let Nb = AtomMeasurement(name: "Nb", atomicRadius: 1.98, ionicRadius: 1.45, covalentRadius: 1.37, vanDerWallsRadius: nil, crystalRadius: 0.78, customRadius: nil, color: beige)
let Mo = AtomMeasurement(name: "Mo", atomicRadius: 1.9, ionicRadius: 1.45, covalentRadius: 1.45, vanDerWallsRadius: nil, crystalRadius: 0.79, customRadius: nil, color: beige)
let Tc = AtomMeasurement(name: "Tc", atomicRadius: 1.83, ionicRadius: 1.35, covalentRadius: 1.56, vanDerWallsRadius: nil, crystalRadius: 0.79, customRadius: nil, color: beige)
let Ru = AtomMeasurement(name: "Ru", atomicRadius: 1.78, ionicRadius: 1.3, covalentRadius: 1.26, vanDerWallsRadius: nil, crystalRadius: 0.82, customRadius: nil, color: beige)
let Rh = AtomMeasurement(name: "Rh", atomicRadius: 1.73, ionicRadius: 1.35, covalentRadius: 1.35, vanDerWallsRadius: nil, crystalRadius: 0.81, customRadius: nil, color: beige)
let Pd = AtomMeasurement(name: "Pd", atomicRadius: 1.69, ionicRadius: 1.4, covalentRadius: 1.31, vanDerWallsRadius: 1.63, crystalRadius: 0.78, customRadius: nil, color: beige)
let Ag = AtomMeasurement(name: "Ag", atomicRadius: 1.65, ionicRadius: 1.6, covalentRadius: 1.53, vanDerWallsRadius: 1.72, crystalRadius: 1.29, customRadius: nil, color: beige)
let Cd = AtomMeasurement(name: "Cd", atomicRadius: 1.61, ionicRadius: 1.55, covalentRadius: 1.48, vanDerWallsRadius: 1.58, crystalRadius: 0.92, customRadius: nil, color: beige)
let In = AtomMeasurement(name: "In", atomicRadius: 1.56, ionicRadius: 1.55, covalentRadius: 1.44, vanDerWallsRadius: 1.93, crystalRadius: 0.94, customRadius: nil, color: beige)
let Sn = AtomMeasurement(name: "Sn", atomicRadius: 1.45, ionicRadius: 1.45, covalentRadius: 1.41, vanDerWallsRadius: 2.17, crystalRadius: 0.69, customRadius: nil, color: beige)
let Sb = AtomMeasurement(name: "Sb", atomicRadius: 1.33, ionicRadius: 1.45, covalentRadius: 1.38, vanDerWallsRadius: nil, crystalRadius: 0.9, customRadius: nil, color: beige)
let Te = AtomMeasurement(name: "Te", atomicRadius: 1.23, ionicRadius: 1.4, covalentRadius: 1.35, vanDerWallsRadius: 2.06, crystalRadius: 1.11, customRadius: nil, color: beige)
let I = AtomMeasurement(name: "I", atomicRadius: 1.15, ionicRadius: 1.4, covalentRadius: 1.33, vanDerWallsRadius: 1.98, crystalRadius: 2.06, customRadius: nil, color: darkViolet)
let Xe = AtomMeasurement(name: "Xe", atomicRadius: 1.08, ionicRadius: 1.08, covalentRadius: 1.3, vanDerWallsRadius: 2.16, crystalRadius: 0.62, customRadius: nil, color: cyan)
let Cs = AtomMeasurement(name: "Cs", atomicRadius: 2.98, ionicRadius: 2.6, covalentRadius: 2.25, vanDerWallsRadius: nil, crystalRadius: 1.81, customRadius: nil, color: violet)
let Ba = AtomMeasurement(name: "Ba", atomicRadius: 2.53, ionicRadius: 2.15, covalentRadius: 1.98, vanDerWallsRadius: nil, crystalRadius: 1.49, customRadius: nil, color: darkGreen)
let La = AtomMeasurement(name: "La", atomicRadius: 1.95, ionicRadius: 1.95, covalentRadius: 1.69, vanDerWallsRadius: nil, crystalRadius: 1.36, customRadius: nil, color: pink)
let Ce = AtomMeasurement(name: "Ce", atomicRadius: 1.85, ionicRadius: 1.85, covalentRadius: nil, vanDerWallsRadius: nil, crystalRadius: 1.15, customRadius: nil, color: pink)
let Pr = AtomMeasurement(name: "Pr", atomicRadius: 2.47, ionicRadius: 1.85, covalentRadius: nil, vanDerWallsRadius: nil, crystalRadius: 1.32, customRadius: nil, color: pink)
let Nd = AtomMeasurement(name: "Nd", atomicRadius: 2.06, ionicRadius: 1.85, covalentRadius: nil, vanDerWallsRadius: nil, crystalRadius: 1.3, customRadius: nil, color: pink)
let Pm = AtomMeasurement(name: "Pm", atomicRadius: 2.05, ionicRadius: 1.85, covalentRadius: nil, vanDerWallsRadius: nil, crystalRadius: 1.28, customRadius: nil, color: pink)
let Sm = AtomMeasurement(name: "Sm", atomicRadius: 2.38, ionicRadius: 1.85, covalentRadius: nil, vanDerWallsRadius: nil, crystalRadius: 1.1, customRadius: nil, color: pink)
let Eu = AtomMeasurement(name: "Eu", atomicRadius: 2.31, ionicRadius: 1.85, covalentRadius: nil, vanDerWallsRadius: nil, crystalRadius: 1.31, customRadius: nil, color: pink)
let Gd = AtomMeasurement(name: "Gd", atomicRadius: 2.33, ionicRadius: 1.8, covalentRadius: nil, vanDerWallsRadius: nil, crystalRadius: 1.08, customRadius: nil, color: pink)
let Tb = AtomMeasurement(name: "Tb", atomicRadius: 2.25, ionicRadius: 1.75, covalentRadius: nil, vanDerWallsRadius: nil, crystalRadius: 1.18, customRadius: nil, color: pink)
let Dy = AtomMeasurement(name: "Dy", atomicRadius: 2.28, ionicRadius: 1.75, covalentRadius: nil, vanDerWallsRadius: nil, crystalRadius: 1.05, customRadius: nil, color: pink)
let Ho = AtomMeasurement(name: "Ho", atomicRadius: 2.26, ionicRadius: 1.75, covalentRadius: nil, vanDerWallsRadius: nil, crystalRadius: 1.04, customRadius: nil, color: pink)
let Er = AtomMeasurement(name: "Er", atomicRadius: 2.26, ionicRadius: 1.75, covalentRadius: nil, vanDerWallsRadius: nil, crystalRadius: 1.03, customRadius: nil, color: pink)
let Tm = AtomMeasurement(name: "Tm", atomicRadius: 2.22, ionicRadius: 1.75, covalentRadius: nil, vanDerWallsRadius: nil, crystalRadius: 1.02, customRadius: nil, color: pink)
let Yb = AtomMeasurement(name: "Yb", atomicRadius: 2.22, ionicRadius: 1.75, covalentRadius: nil, vanDerWallsRadius: nil, crystalRadius: 1.13, customRadius: nil, color: pink)
let Lu = AtomMeasurement(name: "Lu", atomicRadius: 2.17, ionicRadius: 1.75, covalentRadius: 1.6, vanDerWallsRadius: nil, crystalRadius: 1, customRadius: nil, color: pink)
let Hf = AtomMeasurement(name: "Hf", atomicRadius: 2.08, ionicRadius: 1.55, covalentRadius: 1.5, vanDerWallsRadius: nil, crystalRadius: 0.85, customRadius: nil, color: beige)
let Ta = AtomMeasurement(name: "Ta", atomicRadius: 2, ionicRadius: 1.45, covalentRadius: 1.38, vanDerWallsRadius: nil, crystalRadius: 0.78, customRadius: nil, color: beige)
let W = AtomMeasurement(name: "W", atomicRadius: 1.93, ionicRadius: 1.35, covalentRadius: 1.46, vanDerWallsRadius: nil, crystalRadius: 0.74, customRadius: nil, color: beige)
let Re = AtomMeasurement(name: "Re", atomicRadius: 1.88, ionicRadius: 1.35, covalentRadius: 1.59, vanDerWallsRadius: nil, crystalRadius: 0.77, customRadius: nil, color: beige)
let Os = AtomMeasurement(name: "Os", atomicRadius: 1.85, ionicRadius: 1.3, covalentRadius: 1.28, vanDerWallsRadius: nil, crystalRadius: 0.77, customRadius: nil, color: beige)
let Ir = AtomMeasurement(name: "Ir", atomicRadius: 1.8, ionicRadius: 1.35, covalentRadius: 1.37, vanDerWallsRadius: nil, crystalRadius: 0.77, customRadius: nil, color: beige)
let Pt = AtomMeasurement(name: "Pt", atomicRadius: 1.77, ionicRadius: 1.35, covalentRadius: 1.28, vanDerWallsRadius: 1.75, crystalRadius: 0.74, customRadius: nil, color: beige)
let Au = AtomMeasurement(name: "Au", atomicRadius: 1.74, ionicRadius: 1.35, covalentRadius: 1.44, vanDerWallsRadius: 1.66, crystalRadius: 1.51, customRadius: nil, color: beige)
let Hg = AtomMeasurement(name: "Hg", atomicRadius: 1.71, ionicRadius: 1.5, covalentRadius: 1.49, vanDerWallsRadius: 1.55, crystalRadius: 0.83, customRadius: nil, color: beige)
let Tl = AtomMeasurement(name: "Tl", atomicRadius: 1.56, ionicRadius: 1.9, covalentRadius: 1.48, vanDerWallsRadius: 1.96, crystalRadius: 1.03, customRadius: nil, color: beige)
let Pb = AtomMeasurement(name: "Pb", atomicRadius: 1.54, ionicRadius: 1.8, covalentRadius: 1.47, vanDerWallsRadius: 2.02, crystalRadius: 1.49, customRadius: nil, color: beige)
let Bi = AtomMeasurement(name: "Bi", atomicRadius: 1.43, ionicRadius: 1.6, covalentRadius: 1.46, vanDerWallsRadius: nil, crystalRadius: 1.17, customRadius: nil, color: beige)
let Po = AtomMeasurement(name: "Po", atomicRadius: 1.35, ionicRadius: 1.9, covalentRadius: nil, vanDerWallsRadius: nil, crystalRadius: 1.08, customRadius: nil, color: beige)
let At = AtomMeasurement(name: "At", atomicRadius: 1.27, ionicRadius: 1.27, covalentRadius: nil, vanDerWallsRadius: nil, crystalRadius: 0.76, customRadius: nil, color: beige)
let Rn = AtomMeasurement(name: "Rn", atomicRadius: 1.2, ionicRadius: 1.2, covalentRadius: 1.45, vanDerWallsRadius: nil, crystalRadius: nil, customRadius: nil, color: beige)
let Fr = AtomMeasurement(name: "Fr", atomicRadius: nil, ionicRadius: nil, covalentRadius: nil, vanDerWallsRadius: nil, crystalRadius: 1.94, customRadius: nil, color: violet)
let Ra = AtomMeasurement(name: "Ra", atomicRadius: nil, ionicRadius: 2.15, covalentRadius: nil, vanDerWallsRadius: nil, crystalRadius: 1.62, customRadius: nil, color: darkGreen)
let Ac = AtomMeasurement(name: "Ac", atomicRadius: 1.95, ionicRadius: 1.95, covalentRadius: nil, vanDerWallsRadius: nil, crystalRadius: 1.26, customRadius: nil, color: pink)
let Th = AtomMeasurement(name: "Th", atomicRadius: 1.8, ionicRadius: 1.8, covalentRadius: nil, vanDerWallsRadius: nil, crystalRadius: 1.19, customRadius: nil, color: pink)
let Pa = AtomMeasurement(name: "Pa", atomicRadius: 1.8, ionicRadius: 1.8, covalentRadius: nil, vanDerWallsRadius: nil, crystalRadius: 1.09, customRadius: nil, color: pink)
let U = AtomMeasurement(name: "U", atomicRadius: 1.75, ionicRadius: 1.75, covalentRadius: nil, vanDerWallsRadius: 1.86, crystalRadius: 0.87, customRadius: nil, color: pink)
let Np = AtomMeasurement(name: "Np", atomicRadius: 1.75, ionicRadius: 1.75, covalentRadius: nil, vanDerWallsRadius: nil, crystalRadius: nil, customRadius: nil, color: pink)
let Pu = AtomMeasurement(name: "Pu", atomicRadius: 1.75, ionicRadius: 1.75, covalentRadius: nil, vanDerWallsRadius: nil, crystalRadius: 1, customRadius: nil, color: pink)
let Am = AtomMeasurement(name: "Am", atomicRadius: 1.75, ionicRadius: 1.75, covalentRadius: nil, vanDerWallsRadius: nil, crystalRadius: 1.12, customRadius: nil, color: pink)
let Cm = AtomMeasurement(name: "Cm", atomicRadius: nil, ionicRadius: nil, covalentRadius: nil, vanDerWallsRadius: nil, crystalRadius: 1.11, customRadius: nil, color: pink)


// MARK: atomRadii
let atomRadii = ["H":  H,
                 "He": He,
                 "Li": Li,
                 "Be": Be,
                 "B":  B,
                 "C":  C,
                 "N":  N,
                 "O":  O,
                 "F":  F,
                 "Ne": Ne,
                 "Na": Na,
                 "Mg": Mg,
                 "Al": Al,
                 "Si": Si,
                 "P":  P,
                 "S":  S,
                 "Cl": Cl,
                 "Ar": Ar,
                 "K":  K,
                 "Ca": Ca,
                 "Sc": Sc,
                 "Ti": Ti,
                 "V":  V,
                 "Cr": Cr,
                 "Mn": Mn,
                 "Fe": Fe,
                 "Co": Co,
                 "Ni": Ni,
                 "Cu": Cu,
                 "Zn": Zn,
                 "Ga": Ga,
                 "Ge": Ge,
                 "As": As,
                 "Se": Se,
                 "Br": Br,
                 "Kr": Kr,
                 "Rb": Rb,
                 "Sr": Sr,
                 "Y":  Y,
                 "Zr": Zr,
                 "Nb": Nb,
                 "Mo": Mo,
                 "Tc": Tc,
                 "Ru": Ru,
                 "Rh": Rh,
                 "Pd": Pd,
                 "Ag": Ag,
                 "Cd": Cd,
                 "In": In,
                 "Sn": Sn,
                 "Sb": Sb,
                 "Te": Te,
                 "I":  I,
                 "Xe": Xe,
                 "Cs": Cs,
                 "Ba": Ba,
                 "La": La,
                 "Ce": Ce,
                 "Pr": Pr,
                 "Nd": Nd,
                 "Pm": Pm,
                 "Sm": Sm,
                 "Eu": Eu,
                 "Gd": Gd,
                 "Tb": Tb,
                 "Dy": Dy,
                 "Ho": Ho,
                 "Er": Er,
                 "Tm": Tm,
                 "Yb": Yb,
                 "Lu": Lu,
                 "Hf": Hf,
                 "Ta": Ta,
                 "W":  W,
                 "Re": Re,
                 "Os": Os,
                 "Ir": Ir,
                 "Pt": Pt,
                 "Au": Au,
                 "Hg": Hg,
                 "Tl": Tl,
                 "Pb": Pb,
                 "Bi": Bi,
                 "Po": Po,
                 "At": At,
                 "Rn": Rn,
                 "Fr": Fr,
                 "Ra": Ra,
                 "Ac": Ac,
                 "Th": Th,
                 "Pa": Pa,
                 "U":  U,
                 "Np": Np,
                 "Pu": Pu,
                 "Am": Am,
                 "Cm": Cm,]

let maxBonds = [
    "H": 1,
    "He": 0,
    "Li": 7,
    "Be": 6,
    "B": 5,
    "C": 4,
    "N": 3,
    "O": 2,
    "F": 1,
    "Ne": 0,
    "Na": 7,
    "Mg": 6,
    "Al": 5,
    "Si": 4,
    "P": 3,
    "S": 2,
    "Cl": 1,
    "Ar": 0
]
