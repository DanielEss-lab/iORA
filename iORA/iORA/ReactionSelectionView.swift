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
}

struct SubCategory {
    let name: String
    let reactions: [ReactionFile]
}

let subCategories = [
    SubCategory(name: "Reduction",
                reactions: [
                    ReactionFile(name: "AdN Red Acetone", filename: "AdN_Red_Acetone"),
                    ReactionFile(name: "AdN Red Acetone (Updated)", filename: "AdN_Red_Acetone2")
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Bronsted Acid-Base",
                reactions: [
                    ReactionFile(name: "Acid-Base Acetone LDA", filename: "Acid-Base_Acetone_LDA"),
                    ReactionFile(name: "Acid-Base Acetone LDA (Updated)", filename: "Acid-Base_Acetone_LDA2"),
                    ReactionFile(name: "Acid-Base TFA Methoxide", filename: "Acid-Base_TFA_Methoxide"),
                    ReactionFile(name: "Acid-Base TFA Methoxide (Updated)", filename: "Acid-Base_TFA_Methoxide2")
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Alkyl Substitution",
                reactions: [
                    ReactionFile(name: "SN1 Iodotertbutane", filename: "SN1_Iodotertbutane"),
                    ReactionFile(name: "SN1 Iodotertbutane (Updated)", filename: "SN1_Iodotertbutane2"),
                    ReactionFile(name: "SN2 2-Bromobutane", filename: "SN2_2-Bromobutane"),
                    ReactionFile(name: "SN2 2-Bromobutane (Updated)", filename: "SN2_2-Bromobutane2"),
                    ReactionFile(name: "SN2 Chloroethane Nonproductive", filename: "SN2_Chloroethane_nonproductive"),
                    ReactionFile(name: "SN2 Chloroethane Nonproductive (Updated)", filename: "SN2_Chloroethane_nonproductive2"),
                    ReactionFile(name: "SN2 Chloroethane", filename: "SN2_Chloroethane"),
                    ReactionFile(name: "SN2 Chloroethane (Updated)", filename: "SN2_Chloroethane2")
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Acyl Substitution",
                reactions: [
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Elimination",
                reactions: [
                    ReactionFile(name: "E1cb PhenylChloroNitroPropane", filename: "E1cb_PhenylChloroNitroPropane"),
                    ReactionFile(name: "E1cb PhenylChloroNitroPropane (Updated)", filename: "E1cb_PhenylChloroNitroPropane2"),
                    ReactionFile(name: "E2 2-Bromobutane", filename: "E2_2-Bromobutane"),
                    ReactionFile(name: "E2 2-Bromobutane (Updated)", filename: "E2_2-Bromobutane2")
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Alkene Addition",
                reactions: [
                    ReactionFile(name: "AdE Butene", filename: "AdE_Butene"),
                    ReactionFile(name: "AdE Butene (Updated)", filename: "AdE_Butene2"),
                    ReactionFile(name: "AdE Hydroboration", filename: "AdE_Hydroboration"),
                    ReactionFile(name: "AdE Hydroboration (Updated)", filename: "AdE_Hydroboration2"),
                    ReactionFile(name: "AdE Carbene Addition", filename: "AdE_Carbene_addtion"),
                    ReactionFile(name: "AdE Carbene Addition (Updated)", filename: "AdE_Carbene_addtion2")
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Diene Addition",
                reactions: [
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Rearrangement",
                reactions: [
                    ReactionFile(name: "Rearrangement MethylPentylCation", filename: "Rearrangement_MethylPentylCation"),
                    ReactionFile(name: "Rearrangement MethylPentylCation (Updated)", filename: "Rearrangement_MethylPentylCation2")
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Radical",
                reactions: [
                    ReactionFile(name: "AdR TertButyl", filename: "AdR_TertButyl"),
                    ReactionFile(name: "AdR TertButyl (Updated)", filename: "AdR_TertButyl2"),
                    ReactionFile(name: "HAT Butoxy", filename: "HAT_Butoxy"),
                    ReactionFile(name: "HAT Butoxy (Updated)", filename: "HAT_Butoxy2")
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Pericyclic",
                reactions: [
                    ReactionFile(name: "Cope Hexadiene", filename: "Cope_hexadiene"),
                    ReactionFile(name: "Cope Hexadiene (Updated)", filename: "Cope_hexadiene2"),
                    ReactionFile(name: "DA Butadiene Ethene", filename: "DA_Butadiene_Ethene"),
                    ReactionFile(name: "DA Butadiene Ethene (Updated)", filename: "DA_Butadiene_Ethene2"),
                    ReactionFile(name: "Ringclosure Butadiene", filename: "Ringclosure_Butadiene"),
                    ReactionFile(name: "Ringclosure Butadiene (Updated)", filename: "Ringclosure_Butadiene2")
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Conformational Change",
                reactions: [
                    ReactionFile(name: "Conf Butane", filename: "Conf_Butane"),
                    ReactionFile(name: "Conf Butane (Updated)", filename: "Conf_Butane2"),
                    ReactionFile(name: "Conf Cyclohexane", filename: "Conf_Cyclohexane"),
                    ReactionFile(name: "Conf Cyclohexane (Updated)", filename: "Conf_Cyclohexane2")
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Aromatic Substitution",
                reactions: [
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Oxidation",
                reactions: [
                    ReactionFile(name: "AdE Epoxidation Z", filename: "AdE_Epoxidation_Z"),
                    ReactionFile(name: "AdE Epoxidation Z (Updated)", filename: "AdE_Epoxidation_Z2"),
                    ReactionFile(name: "AdE Epoxidation E", filename: "AdE_Epoxidation_E"),
                    ReactionFile(name: "AdE Epoxidation E (Updated)", filename: "AdE_Epoxidation_E2")
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Carbonyl Addition",
                reactions: [
                    ReactionFile(name: "AdN Acetone", filename: "AdN_Acetone"),
                    ReactionFile(name: "AdN Acetone (Updated)", filename: "AdN_Acetone2")
                ].sorted(by: { $0.name < $1.name }))
].sorted(by: { $0.name < $1.name })

struct ReactionSelectionView: View {
    var body: some View {
        NavigationView {
            List(subCategories/*.filter{ $0.reactions.count > 0 }*/, id: \.name) { r in
                NavigationLink(destination: Submenu(reactions: r.reactions, previous: r.name)) {
                    Text(r.name)
                }
                .navigationBarTitleDisplayMode(.inline)
            }
            .navigationTitle("Reactions")
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
