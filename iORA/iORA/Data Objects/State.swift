//
//  State.swift
//  MoleculeDemo4
//
//  Created by Jared Rossberg on 9/28/21.
//  Copyright © 2021 Gabriel Reed. All rights reserved.
//

public class State {
    public let atoms: [Atom]
    public let bonds: [Bond]
    
    init(atoms: [Atom], bonds: [Bond]) {
        self.atoms = atoms
        self.bonds = bonds
    }
}
