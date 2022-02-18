//
//  InfoView.swift
//  iORA
//
//  Created by Jared Rossberg on 2/9/22.
//

import SwiftUI

struct InfoView: View {
    var atoms: [String]
    var labelName: String
    var labelData: String
    
    var body: some View {
        HStack {
            VStack {
                ForEach (
                    0..<atoms.count,
                    id: \.self
                ) {
                    Text("Atom \($0+1)")
                }
                Text(labelName)
            }
            VStack {
                ForEach (
                    0..<atoms.count,
                    id: \.self
                ) {
                    Text(atoms[$0])
                }
                Text(labelData)
            }
        }
        .padding()
        .overlay(
            RoundedRectangle(cornerRadius: 0)
                .stroke(Color.white , lineWidth: 2)
        )
        .offset(x:20)
        .foregroundColor(Color.white)
    }
}

struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView(atoms: ["C","C","H"],
                 labelName: "Distance",
                 labelData: String(4.6702876))
    }
}
