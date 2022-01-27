//
//  Bond.swift
//  MoleculeDemo4
//
//  Created by Jared Rossberg on 9/28/21.
//  Copyright © 2021 Gabriel Reed. All rights reserved.
//

public class Bond {
    public let atom1, atom2: Atom
    public let order: Double

    init(_ atom1: Atom, _ atom2: Atom, _ order: Double) {
        self.atom1 = atom1
        self.atom2 = atom2
        self.order = order
    }
}
