//
//  ReactionSelectionView.swift
//  iORA
//
//  Created by Jared Rossberg on 1/12/22.
//

import SwiftUI

struct ReactionFile {
    let name: String
    let filename: String
    let transitionState: Int
}

struct SubCategory {
    let name: String
    let reactions: [ReactionFile]
}

let subCategories = [
    SubCategory(name: "Conformational Change",
                reactions: [
                    ReactionFile(name: "Conf Butane", filename: "butane_eclipsed", transitionState: -1),
                    ReactionFile(name: "Ethane", filename: "ethane_TS_10K", transitionState: -1),
                    ReactionFile(name: "Chloroethane", filename: "Chloroenthane_TS_10K", transitionState: -1),
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Bronsted Acid-Base",
                reactions: [
                    ReactionFile(name: "Acetone-LDA", filename: "Acid-Base_Acetone_LDA", transitionState: -1),
                    ReactionFile(name: "Trifluoroacetic Acid-Methoxide", filename: "Acid-Base_TFA_Methoxide", transitionState: -1)
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Alkyl Substitution",
                reactions: [
                    ReactionFile(name: "SN1: Tert-Butyl Iodide", filename: "SN1_Iodotertbutane", transitionState: -1),
                    ReactionFile(name: "SN2: 2-Bromobutane", filename: "SN2_2-Bromobutane", transitionState: 500), // 525
                    ReactionFile(name: "SN2: Nonproductive Ethyl Chloride", filename: "SN2_Chloroethane_nonproductive", transitionState: -1),
                    ReactionFile(name: "SN2: Ethyl Chloride", filename: "SN2_Chloroethane", transitionState: 1000), //1020
                    ReactionFile(name: "SN2: Methyl Iodide", filename: "Nitrogen_Methyl_Iodine", transitionState: 220),
                    ReactionFile(name: "SN2: Methyl Ammonium", filename: "SN2_Methyl_Ammonium", transitionState: 435), //424
                    ReactionFile(name: "SN2: Benzyl Bromide", filename: "MethylOxide_BenzylBromide", transitionState: 163), // 162
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Elimination",
                reactions: [
                    ReactionFile(name: "E1cb", filename: "E1cb_PhenylChloroNitroPropane", transitionState: -1),
                    ReactionFile(name: "E2: 2-Bromobutane (Primary)", filename: "2-BromobutaneMeO", transitionState: 1002), // 1004
                    ReactionFile(name: "E2: 2-Bromobutane (Secondary)", filename: "2-Bromobutane_E2_Butene", transitionState: 353),
                    //ReactionFile(name: "SN2: 2-Bromobutane (Secondary)", filename: "SN2_2-Bromobutane_secondary", transitionState: 353),
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Alkene Addition",
                reactions: [
                    ReactionFile(name: "HBr Addition", filename: "AdE_Butene", transitionState: 158), // 154
                    ReactionFile(name: "BH3 Hydroboration", filename: "AdE_Hydroboration", transitionState: 0),
                    ReactionFile(name: "CCl2 Carbene Addition", filename: "AdE_Carbene_addtion", transitionState: 250), //275
                    ReactionFile(name: "Triplet-Singlet CH2 Carbene-Ethylene", filename: "carbene_TS_cyclopantane_triplet_TS200", transitionState: 200),
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Alkyne Addition",
                reactions: [
                    ReactionFile(name: "3-Hexyne Hydrochloric", filename: "3-Hexyne_Hydrochloric", transitionState: 231), // 233
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Diene Addition",
                reactions: [
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Rearrangement",
                reactions: [
                    ReactionFile(name: "Secondary Carbocation Shift", filename: "MethylPentylCation_short", transitionState: -1), // 159
                    ReactionFile(name: "Secondary Carbocation Shift (Extended Animation)", filename: "Rearrangement_MethylPentylCation", transitionState: -1) // 269
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Oxidation",
                reactions: [
                    ReactionFile(name: "Trans Alkene Epoxidation", filename: "Butene_EA_dimethyloxirane", transitionState: 527) // 528
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Reduction",
                reactions: [
                    ReactionFile(name: "LAH Reduction", filename: "AdN_Red_Acetone", transitionState: 1013)
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Carbonyl Addition",
                reactions: [
                    ReactionFile(name: "Cyanide Addition", filename: "AdN_Acetone", transitionState: 429) // 435
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Acyl Substitution",
                reactions: [
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Radical",
                reactions: [
                    ReactionFile(name: "Intramolecular HAT", filename: "HAT_Butoxy", transitionState: 426), //430
                    ReactionFile(name: "CH4-Chlorine Radical", filename: "MethaneChlorineRadical", transitionState: 55),
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Pericyclic",
                reactions: [
                    ReactionFile(name: "Cope", filename: "hexadiene_cope_hexadiene_complete", transitionState: 501),
                    // ReactionFile(name: "Cope", filename: "Cope_hexadiene", transitionState: 1000),
                    ReactionFile(name: "Butadiene-Ethylene", filename: "butadiene_ethene_DA_cyclohexane_complete", transitionState: 200), // 226
                    //ReactionFile(name: "Butadiene-Ethylene 2", filename: "DA_Butadiene_Ethene", transitionState: 150),
                    ReactionFile(name: "Electrocyclic Ring Closing", filename: "Ringclosure_Butadiene", transitionState: 1000),
                    ReactionFile(name: "Ene Reaction", filename: "EneReaction", transitionState: 127),
                    ReactionFile(name: "OsO4-Ethylene", filename: "OsO4_complete", transitionState: 501), // 526
                    // ReactionFile(name: "OsO4-Ethylene", filename: "OsmiumTetroxide_Ethylene", transitionState: 157),
                    ReactionFile(name: "Ozone-Ethylene", filename: "Ozone_complete", transitionState: 499), // 524
                    // ReactionFile(name: "Ozone-Ethylene", filename: "Ozone_Ethylene", transitionState: 253),
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Aromatic Substitution",
                reactions: [
                    ReactionFile(name: "Friedel-Crafts Acylation", filename: "Toluene_acylium_AlCl4_TS_tolylethanone", transitionState: 499), // 522
                ].sorted(by: { $0.name < $1.name })),
    /*SubCategory(name: "Uncategorized",
                reactions: [
                    ReactionFile(name: "butadiene_acrylate_DA_cyclohexenecarboxylate_complete", filename: "butadiene_acrylate_DA_cyclohexenecarboxylate_complete", transitionState: 458),
                    ReactionFile(name: "dimethylhexadiene_cope_octadiene_complete", filename: "dimethylhexadiene_cope_octadiene_complete", transitionState: 847),
                ]),*/
]

struct ReactionSelectionView: View {
    var body: some View {
        //NavigationView {
             ZStack {
                List(subCategories/*.filter{ $0.reactions.count > 0 }*/, id: \.name) { r in
                    NavigationLink(destination: Submenu(reactions: r.reactions, previous: r.name)) {
                        Text(r.name)
                    }
                    .navigationBarTitleDisplayMode(.inline)
                }
                .navigationTitle("Reactions")
                .toolbar {
                    NavigationLink(destination: OptionsView()) {
                        Image(systemName: "gear")
                            .onAppear {
                                let defaultInit = Defaults() //It might be better to put this in AppDelegate or even SceneDelegate
                                defaultInit.setUp()
                            }.padding()
                    }
                }
                 
             }
        //}
        
    }
}

struct EmptyPage: View {
    var body: some View {
        VStack {
            Spacer()
            Text("Check back soon to see more reactions!")
            Spacer()
            Spacer()
            Spacer()
        }
    }
}

struct Submenu: View {
    let reactions: [ReactionFile]
    let previous: String
    var body: some View {
        getDestination()
    }
    
    func getDestination() -> AnyView {
        switch reactions.count {
        case 0:
            return AnyView(EmptyPage())
        case 1:
            return AnyView(ReactionView(reactionFile: reactions[0]))
        default:
            return AnyView(
                List(reactions, id: \.name) { r in
                    NavigationLink(destination: ReactionView(reactionFile: r)) {
                        Text(r.name)
                    }.navigationBarTitleDisplayMode(.inline)
                }.navigationTitle(previous)
            )
        }
    }
}
