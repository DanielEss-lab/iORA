//
//  Atom.swift
//  MoleculeDemo4
//
//  Created by Jared Rossberg on 9/28/21.
//  Copyright © 2021 Gabriel Reed. All rights reserved.
//

public class Atom {
    public let symbol: String // I'd prefer this to be an enum, but ¯\_(ツ)_/¯
    public let xPosition, yPosition, zPosition: Double

    init(symbol: String, x: Double, y: Double, z: Double) {
        self.symbol = symbol
        xPosition = x
        yPosition = y
        zPosition = z
    }
}
