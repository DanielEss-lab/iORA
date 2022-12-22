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
                    ReactionFile(name: "Butane (Anti to Gauche)", filename: "butane_eclipsed", transitionState: -1),
                    ReactionFile(name: "Ethane (C-C Rotation)", filename: "ethane_TS_10K", transitionState: -1),
                    ReactionFile(name: "Chloroethane (C-C Rotation)", filename: "Chloroenthane_TS_10K", transitionState: -1),
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Bronsted Acid-Base",
                reactions: [
                    ReactionFile(name: "Acetone-LDA", filename: "Acid-Base_Acetone_LDA", transitionState: -1),
                    ReactionFile(name: "Trifluoroacetic Acid-Methoxide", filename: "Acid-Base_TFA_Methoxide", transitionState: -1)
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Alkyl Substitution",
                reactions: [
                    ReactionFile(name: "SN1: Tert-Butyl Iodide", filename: "SN1_Iodotertbutane", transitionState: -1),
                    ReactionFile(name: "SN2: 2-Bromobutane + Methoxide", filename: "SN2_2-Bromobutane", transitionState: 500), // 525
                    ReactionFile(name: "SN2: Nonproductive Ethyl Chloride + Cyanide", filename: "SN2_Chloroethane_nonproductive", transitionState: -1),
                    ReactionFile(name: "SN2: Ethyl Chloride + Cyanide", filename: "SN2_Chloroethane", transitionState: 1000), //1020
                    ReactionFile(name: "SN2: Methyl Iodide + Ammonia", filename: "Nitrogen_Methyl_Iodine", transitionState: 220),
                    ReactionFile(name: "SN2: Methyl Ammonium + Methanethiolate", filename: "SN2_Methyl_Ammonium", transitionState: 435), //424
                    ReactionFile(name: "SN2: Benzyl Bromide + Methoxide", filename: "MethylOxide_BenzylBromide", transitionState: 163), // 162
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Elimination",
                reactions: [
                    ReactionFile(name: "E1cb: Alkyl Chloride + Methoxide", filename: "E1cb_PhenylChloroNitroPropane", transitionState: -1),
                    ReactionFile(name: "E2: 2-Bromobutane (Primary) + Methoxide", filename: "2-BromobutaneMeO", transitionState: 1002), // 1004
                    ReactionFile(name: "E2: 2-Bromobutane (Secondary) + Methoxide", filename: "2-Bromobutane_E2_Butene", transitionState: 353),
                    //ReactionFile(name: "SN2: 2-Bromobutane (Secondary)", filename: "SN2_2-Bromobutane_secondary", transitionState: 353),
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Alkene Addition",
                reactions: [
                    ReactionFile(name: "HX: HBr + Isobutylene", filename: "AdE_Butene", transitionState: 158), // 154
                    ReactionFile(name: "Hydroboration: BH₃ + 1-Butene", filename: "AdE_Hydroboration", transitionState: 0),
                    ReactionFile(name: "Carbene: CCl₂ + Ethylene", filename: "AdE_Carbene_addtion", transitionState: 250), //275
                    ReactionFile(name: "Carbene: CH₂ + Ethylene (Triplet-Singlet Flip)", filename: "carbene_TS_cyclopantane_triplet_TS200", transitionState: 200),
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Alkyne Addition",
                reactions: [
                    ReactionFile(name: "HX: HCl + 3-Hexyne", filename: "3-Hexyne_Hydrochloric", transitionState: 231), // 233
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Diene Addition",
                reactions: [
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Rearrangement",
                reactions: [
                    ReactionFile(name: "Secondary to Tertiary Shift", filename: "MethylPentylCation_short", transitionState: -1), // 159
                    ReactionFile(name: "Secondary to Tertiary Shift (Extended Animation)", filename: "Rearrangement_MethylPentylCation", transitionState: -1) // 269
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Oxidation",
                reactions: [
                    ReactionFile(name: "Epoxidation: Peracid + Trans-2-Butene", filename: "Butene_EA_dimethyloxirane", transitionState: 527) // 528
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Reduction",
                reactions: [
                    ReactionFile(name: "Hydride Reduction: LAH + Acetone", filename: "AdN_Red_Acetone", transitionState: 1013)
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Carbonyl Addition",
                reactions: [
                    ReactionFile(name: "Addition: Cyanide + Acetone", filename: "AdN_Acetone", transitionState: 429), // 435
                    ReactionFile(name: "Gignard: MeMgBr + Propionaldehyde", filename: "propanal_NA_secbutanol", transitionState: 700),
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Acyl Substitution",
                reactions: [
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Radical",
                reactions: [
                    ReactionFile(name: "Intramolecular HAT", filename: "HAT_Butoxy", transitionState: 426), //430
                    ReactionFile(name: "Hydrogen Atom Transfer (HAT): CH₄ + Cl Radical", filename: "MethaneChlorineRadical", transitionState: 55),
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Pericyclic",
                reactions: [
                    ReactionFile(name: "Cope: 1,5-hexadiene", filename: "hexadiene_cope_hexadiene_complete", transitionState: 501),
                    ReactionFile(name: "Cope: 3,4-Dimethylhexa-1,5-diene", filename: "dimethylhexadiene_cope_octadiene_complete", transitionState: 849),
                    // ReactionFile(name: "Cope", filename: "Cope_hexadiene", transitionState: 1000),
                    ReactionFile(name: "Diels-Alder: 1,3-Butadiene + Ethylene", filename: "butadiene_ethene_DA_cyclohexane_complete", transitionState: 200), // 226
                    ReactionFile(name: "Diels-Alder: 1,3-Butadiene + Enone", filename: "butadiene_acrylate_DA_cyclohexenecarboxylate_complete", transitionState: 449),
                    //ReactionFile(name: "Butadiene-Ethylene 2", filename: "DA_Butadiene_Ethene", transitionState: 150),
                    ReactionFile(name: "Electrocyclic: Cyclobutene", filename: "Ringclosure_Butadiene", transitionState: 1000),
                    ReactionFile(name: "Electrocyclic: 3,4-Dimethylcyclobutene", filename: "hexadiene_TS_dimethylcyclobutene", transitionState: 1000),
                    ReactionFile(name: "Ene: Propylene + Ethylene", filename: "EneReaction", transitionState: 127),
                    ReactionFile(name: "OsO₄ + Ethylene", filename: "OsO4_complete", transitionState: 501), // 526
                    // ReactionFile(name: "OsO4-Ethylene", filename: "OsmiumTetroxide_Ethylene", transitionState: 157),
                    ReactionFile(name: "1,3-Dipolar Cycloaddition: O₃ + Ethylene", filename: "Ozone_complete", transitionState: 499), // 524
                    // ReactionFile(name: "Ozone-Ethylene", filename: "Ozone_Ethylene", transitionState: 253),
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Aromatic Substitution",
                reactions: [
                    ReactionFile(name: "Friedel-Crafts Acylation", filename: "Toluene_acylium_AlCl4_TS_tolylethanone", transitionState: 499), // 522
                ].sorted(by: { $0.name < $1.name })),
    /*SubCategory(name: "Uncategorized",
                reactions: [
                    //ReactionFile(name: "butadiene_acrylate_DA_cyclohexenecarboxylate_complete", filename: "butadiene_acrylate_DA_cyclohexenecarboxylate_complete", transitionState: 458),
                    //ReactionFile(name: "dimethylhexadiene_cope_octadiene_complete", filename: "dimethylhexadiene_cope_octadiene_complete", transitionState: 847),
                ]),*/
]

struct ReactionSelectionView: View {
    var body: some View {
        NavigationView {
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
        }
        
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
