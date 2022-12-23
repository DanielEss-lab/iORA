//
//  Infopage.swift
//  iORA
//
//  Created by Jared Rossberg on 12/23/22.
//

import SwiftUI

struct Infopage: View {
    let reaction: ReactionFile
    
    var body: some View {
        Text(reaction.description)
            .onDisappear {
                print("gone")
            }
    }
}
