//
//  Reaction.swift
//  MoleculeDemo4
//
//  Created by Jared Rossberg on 9/28/21.
//  Copyright © 2021 Gabriel Reed. All rights reserved.
//

public class Reaction {
    private var states: [StateObj]
    public let solvent: Bool //FIXME: this may be unnecessary

    init() {
        states = []
        self.solvent = false //FIXME: delete if unnecessary
    }
    
    public func addState(_ state: StateObj) {
        self.states.append(state)
    }
    
    public func getStates() -> [StateObj] {
        return self.states
    }
}
