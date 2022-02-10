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
    var atom3: String
    var labelName: String
    var labelData: String
    
    var body: some View {
        HStack {
            VStack {
                Text("Atom 1:")
                Text("Atom 2:")
                Text("Atom 3:")
                Text(labelName+":")
            }
            VStack {
                Text(atom1)
                Text(atom2)
                Text(atom3)
                Text(labelData)
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
        InfoView(atom1: "C",
                 atom2: "C",
                 atom3: "H",
                 labelName: "Distance",
                 labelData: String(4.6702876))
    }
}
