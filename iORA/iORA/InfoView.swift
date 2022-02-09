//
//  InfoView.swift
//  iORA
//
//  Created by Jared Rossberg on 2/9/22.
//

import SwiftUI

struct InfoView: View {
    var atom1: String
    var atom2: String
    var dist: String
    
    var body: some View {
        HStack {
            VStack {
                Text("Atom 1:")
                Text("Atom 2:")
                Text("Distance:")
            }
            VStack {
                Text(atom1)
                Text(atom2)
                Text(dist)
            }
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black , lineWidth: 2)
        )
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(atom1: "C", atom2: "C", dist: String(4.6702876))
    }
}
