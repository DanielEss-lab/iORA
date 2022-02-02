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
    ReactionFile(name: "Cyclobutane", filename: "cyclobutanetraj1"),
    ReactionFile(name: "2-Bromobutane_E2_Butene", filename: "2-Bromobutane_E2_Butene"),
    ReactionFile(name: "2-Bromobutane_SN2_2-Methoxybutane", filename: "2-Bromobutane_SN2_2-Methoxybutane"),
    ReactionFile(name: "Acetone_NA_2-Hydroxy-2-Methylpropanenitrile", filename: "Acetone_NA_2-hydroxy-2-methylpropanenitrile"),
    ReactionFile(name: "Butene_EA_Bromobutane", filename: "Butene_EA_bromobutane"),
    ReactionFile(name: "Butoxy_TS_Hydroxybutyl", filename: "Butoxy_TS_hydroxybutyl"),
    ReactionFile(name: "Iodotertbutane_SN1_Tertbutyl", filename: "Iodotertbutane_SN1_tertbutyl"),
    ReactionFile(name: "SN2", filename: "SN2"),
    ReactionFile(name: "TertButyl_RA_Tertpentyl", filename: "TertButyl_RA_tertpentyl"),
    ReactionFile(name: "Hexadiene_Cope_Hexadiene", filename: "hexadiene_cope_hexadiene"),
    ReactionFile(name: "Butadiene_Ethene_DA_Cyclohexane", filename: "butadiene_ethene_DA_cyclohexane"),
    ReactionFile(name: "Cyclohexane", filename: "cyclohexane")
].sorted(by: { $0.name < $1.name })

struct ReactionSelectionView: View {
    var body: some View {
        NavigationView {
            List(reactionFiles, id: \.name) { r in
                NavigationLink(destination: ReactionView(reactionFile: r)) {
                    Text(r.name)
                }
                .navigationBarTitleDisplayMode(.inline)
            }
            .navigationTitle("Reaction Selection")
        }
    }
}

/*struct ReactionSelectionView_Previews: PreviewProvider {
    static var previews: some View {
        ReactionSelectionView()
    }
}*/
