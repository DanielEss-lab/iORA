//
//  ReactionSelectionView.swift
//  MoleculeDemo4
//
//  Created by Jared Rossberg on 10/6/21.
//

import SwiftUI

struct ReactionFile {
    let name: String
    let filename: String
}

let reactionFiles = [
    ReactionFile(name: "Bullvalene", filename: "bullvalenetraj"),
    ReactionFile(name: "Cyclobutane", filename: "cyclobutanetraj1")
].sorted(by: { $0.name < $1.name })

struct ReactionSelectionView: View {
    var body: some View {
        NavigationView {
            List(reactionFiles, id: \.name) { r in
                NavigationLink(destination: ReactionView(reactionFile: r)) {
                    Text(r.name)
                }
            }
            .navigationTitle("Reaction Selection")
        }
    }
}

struct ReactionSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ReactionSelectionView()
    }
}
