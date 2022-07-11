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
    SubCategory(name: "Reduction",
                reactions: [
                    ReactionFile(name: "LAH Reduction", filename: "AdN_Red_Acetone", transitionState: 1005)
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Bronsted Acid-Base",
                reactions: [
                    ReactionFile(name: "Acetone-LDA", filename: "Acid-Base_Acetone_LDA", transitionState: 522),
                    ReactionFile(name: "Trifluoroacetic Acid-Methoxide", filename: "Acid-Base_TFA_Methoxide", transitionState: 57)
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Alkyl Substitution",
                reactions: [
                    ReactionFile(name: "SN1: Tert-Butyl Iodide", filename: "SN1_Iodotertbutane", transitionState: 75),
                    ReactionFile(name: "SN2: 2-Bromobutane", filename: "SN2_2-Bromobutane", transitionState: 525),
                    ReactionFile(name: "SN2: Nonproductive Ethyl Chloride", filename: "SN2_Chloroethane_nonproductive", transitionState: 0),
                    ReactionFile(name: "SN2: Ethyl Chloride", filename: "SN2_Chloroethane", transitionState: 1020)
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Acyl Substitution",
                reactions: [
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Elimination",
                reactions: [
                    ReactionFile(name: "E1cb", filename: "E1cb_PhenylChloroNitroPropane", transitionState: 245),
                    ReactionFile(name: "E2: 2-Bromobutane", filename: "E2_2-Bromobutane", transitionState: 350)
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Alkene Addition",
                reactions: [
                    ReactionFile(name: "HBr Addition", filename: "AdE_Butene", transitionState: 1000),
                    ReactionFile(name: "BH3 Hydroboration", filename: "AdE_Hydroboration", transitionState: 200),
                    ReactionFile(name: "CCI2 Carbene Addition", filename: "AdE_Carbene_addtion", transitionState: 275)
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Diene Addition",
                reactions: [
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Rearrangement",
                reactions: [
                    ReactionFile(name: "Secondary Carbocation Shift", filename: "Rearrangement_MethylPentylCation", transitionState: 269)
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Radical",
                reactions: [
                    //ReactionFile(name: "AdR TertButyl", filename: "AdR_TertButyl", transitionState: 1025),
                    ReactionFile(name: "Intramolecular HAT", filename: "HAT_Butoxy", transitionState: 430)
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Pericyclic",
                reactions: [
                    ReactionFile(name: "Cope", filename: "Cope_hexadiene", transitionState: 1000),
                    ReactionFile(name: "Butadiene-Ethylene", filename: "DA_Butadiene_Ethene", transitionState: 175),
                    ReactionFile(name: "Electrocyclic Ring Closing", filename: "Ringclosure_Butadiene", transitionState: 1015)
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Conformational Change",
                reactions: [
                    ReactionFile(name: "Conf Butane", filename: "Conf_Butane", transitionState: 0),
                    //ReactionFile(name: "Conf Cyclohexane", filename: "Conf_Cyclohexane", transitionState: 0)
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Aromatic Substitution",
                reactions: [
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Oxidation",
                reactions: [
                    ReactionFile(name: "Cis Alkene Epoxidation", filename: "AdE_Epoxidation_Z", transitionState: 1010),
                    ReactionFile(name: "Trans Alkene Epoxidation", filename: "AdE_Epoxidation_E", transitionState: 1020)
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Carbonyl Addition",
                reactions: [
                    ReactionFile(name: "Cyanide Addition", filename: "AdN_Acetone", transitionState: 435)
                ].sorted(by: { $0.name < $1.name }))
].sorted(by: { $0.name < $1.name })

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
