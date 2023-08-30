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
    let description: String
}

struct SubCategory {
    let name: String
    let reactions: [ReactionFile]
}

let subCategories = [
    SubCategory(name: "Conformational Change",
                reactions: [
                    ReactionFile(
                        name: "Butane (Anti to Gauche)", filename: "butane_eclipsed", transitionState: -1,
                        description: "This trajectory shows a simulation of butane with enough energy to achieve the transition state (eclipsed geometry) for rotation around the C2-C3 bond. This transition state connects the lower energy anti conformation with the higher energy gauche conformation. Notice that during the trajectory there is rotation of both the C2-C3 bond and the C1-C2 bond, but not at the exact same time."),
                    ReactionFile(
                        name: "Ethane (C-C Rotation)", filename: "ethane_TS_10K", transitionState: -1,
                        description: "This trajectory shows a simulation of ethane for rotation around the C-C bond. This involves proceeding through the eclipsed conformation that connects the staggered conformations."),
                    ReactionFile(
                        name: "Chloroethane (C-C Rotation)", filename: "Chloroenthane_TS_10K", transitionState: -1,
                        description: ""),
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Bronsted Acid-Base",
                reactions: [
                    ReactionFile(
                        name: "Acetone-LDA", filename: "Acid-Base_Acetone_LDA", transitionState: -1,
                        description: "This trajectory shows that the basic nitrogen must first orient properly to react with the C-H bond of acetone. This involves a linear arrangement, 180 degree angle, between the nitrogen atom, the transferring proton, and the carbon that is being deprotonated."),
                    ReactionFile(
                        name: "Trifluoroacetic Acid-Methoxide", filename: "Acid-Base_TFA_Methoxide", transitionState: -1,
                        description: "This trajectory shows the proton transfer reaction between methoxide and trifluoroacetic acid. Hydrogen bonding precedes, but only for a very short time, proton transfer. Notice that the proton transfers back and forth very rapidly between methoxide and trifluoroacetate several times before dissociation of methanol.")
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Alkyl Substitution",
                reactions: [
                    ReactionFile(
                        name: "SN1: Tert-Butyl Iodide (Stage 1)", filename: "TertButylIodide_SN1_stage1", transitionState: -1,
                        description: ""),
                    ReactionFile(
                        name: "SN1: Tert-Butyl Iodide (Stage 2)", filename: "TertButylAcetate_SN1_stage2", transitionState: -1,
                        description: ""),
                    ReactionFile(
                        name: "SN2: 2-Bromobutane + Methoxide", filename: "SN2_2-Bromobutane", transitionState: 500,
                        description: "This SN2 trajectory shows the methoxide nucleophile collision into the backside of the C-Br bond with enough energy and at the correct angle to induce a new O-C bond and cleavage of the C-Br bond. Note that at the beginning of the trajectory the methoxide nucleophile weakly interacts with C-H bonds adjacent to the C-Br bond. The corresponding E2 trajectory animation shows the competitive E2 reaction. The SN2 and E2 trajectories are competitive because their transition states are close in energy."),
                    ReactionFile(
                        name: "SN2: Nonproductive Ethyl Chloride + Cyanide", filename: "SN2_Chloroethane_nonproductive", transitionState: -1,
                        description: "Most collisions between reactants do not lead to the transition state geometry. Rather, reactants often collide and bounce away from each other in what is referred to as a nonproductive collision. This trajectory shows an example where a cyanide anion collides with chloroethane without leading to the SN2 transition state. Compare this nonproductive trajectory with the productive SN2 reaction."),
                    ReactionFile(
                        name: "SN2: Ethyl Chloride + Cyanide", filename: "SN2_Chloroethane", transitionState: 1000, description: "This SN2 trajectory shows the cyanide nucleophile collision into the backside of the C-Cl bond with enough energy and at the correct angle to induce a new CN-C bond and cleavage of the C-Cl bond."),
                    ReactionFile(
                        name: "SN2: Methyl Iodide + Ammonia", filename: "Nitrogen_Methyl_Iodine", transitionState: 220,
                        description: ""),
                    ReactionFile(
                        name: "SN2: Methyl Ammonium + Methanethiolate", filename: "SN2_Methyl_Ammonium", transitionState: 435,
                        description: ""),
                    ReactionFile(
                        name: "SN2: Benzyl Bromide + Methoxide", filename: "MethylOxide_BenzylBromide", transitionState: 163,
                        description: ""),
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Elimination",
                reactions: [
                    ReactionFile(
                        name: "E1cb: Alkyl Chloride + Methoxide", filename: "E1cb_PhenylChloroNitroPropane", transitionState: -1,
                        description: ""),
                    ReactionFile(
                        name: "E2: 2-Bromobutane (Primary) + Methoxide", filename: "2-BromobutaneMeO", transitionState: 1002,
                        description: ""),
                    ReactionFile(
                        name: "E2: 2-Bromobutane (Secondary) + Methoxide", filename: "2-Bromobutane_E2_Butene", transitionState: 353,
                        description: "This E2 trajectory shows that the methoxide base deprotonates the beta anti-periplanar hydrogen on C-3. As this deprotonation occurs, the π bond is formed and the bromide is ejected. Use the transition state (TS) button to examine key distances: the base to the beta hydrogen, the C-2 to C-3 distance, and the C-Br distance."),
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Alkene Addition",
                reactions: [
                    ReactionFile(
                        name: "HX: HBr + Isobutylene", filename: "AdE_Butene", transitionState: 158,
                        description: "This hydrohalogenation trajectory shows HBr protonation of isobutylene to generate a tertiary carbocation intermediate. Because this trajectory does not have solvent around to stabilize the carbocation, bromide very quickly forms the C-Br bond to give the additional product. With solvent around the carbocation would exist for a much longer time."),
                    ReactionFile(
                        name: "Hydroboration: BH₃ + 1-Butene", filename: "AdE_Hydroboration", transitionState: 0,
                        description: "Hydroboration of an alkene generally does not involve a carbocation intermediate. This trajectory shows the reaction between the electrophile BH3 and 1-butene. In the early time of the trajectory the π bond interacts with the electrophilic boron. Very soon after this electrophilic interaction the boron transfers a hydride to the C-2 atom and this occurs without forming a carbocation intermediate."),
                    ReactionFile(
                        name: "Carbene: CCl₂ + Ethylene", filename: "AdE_Carbene_addtion", transitionState: 250,
                        description: "This trajectory shows the reactive collision between dichlorocarbene (a divalent form of carbon) and ethylene. The trajectory progresses through a transition state (use the TS button) where the dominant interaction is between the ethylene π orbital and the empty p orbital of the carbene. This trajectory shows there is no carbocation intermediate and both new C-C bonds are asynchronously formed in one reaction step."),
                    ReactionFile(
                        name: "Carbene: CH₂ + Ethylene (Triplet-Singlet Flip)", filename: "carbene_TS_cyclopantane_triplet_TS200", transitionState: 200,
                        description: "This trajectory shows the collision of triplet carbene with ethylene. Triplet carbene two same spin unpaired electrons. In the collision there is first formation of one new C-C bond with simultaneous rupture of the π bond. The diradical intermediate is still a triplet with the same spin electrons. Then the intermediate undergoes triplet to singlet spin state change, which allows formation of the second C-C bond."),
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Alkyne Addition",
                reactions: [
                    ReactionFile(
                        name: "HX: HCl + 3-Hexyne", filename: "3-Hexyne_Hydrochloric", transitionState: 231,
                        description: "This trajectory shows the protonation of a disubstituted alkyne by HCl. Because no solvent was included in this simulation, and vinyl carbocations are inherently unstable compared to alkyl carbocations, there is no long-lived vinyl carbocation intermediate. Therefore, in this trajectory the addition occurs in a cis fashion."),
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Diene Addition",
                reactions: [
                    ReactionFile(
                        name: "1,4-Addition: HCl + 1,3-pentadiene", filename: "HCl-1,3,diene_full", transitionState: 300,
                        description: "")
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Rearrangement",
                reactions: [
                    ReactionFile(
                        name: "Secondary to Tertiary Shift", filename: "MethylPentylCation_short", transitionState: -1,
                        description: "This trajectory shows a secondary carbocation and the hydride shift to generate a more stable tertiary carbocation. The extended animation below shows the hydride shift back and forth multiple times before ending as the tertiary carbocation."),
                    ReactionFile(
                        name: "Secondary to Tertiary Shift (Extended Animation)", filename: "Rearrangement_MethylPentylCation", transitionState: -1,
                        description: "")
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Oxidation",
                reactions: [
                    ReactionFile(
                        name: "Epoxidation: Peracid + Trans-2-Butene", filename: "Butene_EA_dimethyloxirane", transitionState: 527,
                        description: "Epoxidation of an alkene is a reaction that does not have an intermediate. This trajectory shows the collision and reaction of a model peroxy acid with trans-2-butene. The nucleophilic π bond of the alkene simultaneously forms two bonds with the electrophilic oxygen of the peroxy acid. This trajectory shows that there is no carbocation intermediate and therefore the trans relationship of the alkene methyl groups remains in the epoxide product.")
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Reduction",
                reactions: [
                    ReactionFile(
                        name: "Hydride Reduction: LAH + Acetone", filename: "AdN_Red_Acetone", transitionState: 1013,
                        description: "This trajectory shows the reaction of LiAlH4 with acetone and results in hydride transfer. This trajectory shows that the Li cation templates the motion and direction of hydride transfer to the carbonyl. After hydride addition the anionic oxygen interacts with borane.")
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Carbonyl Addition",
                reactions: [
                    ReactionFile(
                        name: "Addition: Cyanide + Acetone", filename: "AdN_Acetone", transitionState: 429,
                        description: "This trajectory shows the addition of cyanide to the carbon atom of acetone to form a new C-CN bond with simultaneous cleavage of the C=O π bond. However, before addition, this trajectory shows an initial unproductive collision between cyanide and the ketone. It is important to realize that many unproductive collisions occur between reacting compounds before a productive, product-forming collision occurs."),
                    ReactionFile(
                        name: "Gignard: MeMgBr + Propionaldehyde", filename: "propanal_NA_secbutanol", transitionState: 700,
                        description: "This trajectory shows that the Mg coordinates to the carbonyl oxygen before delivery of the methyl anion to the carbonyl carbon. After methyl group transfer the Mg remains tightly coordinated to the negatively charged oxygen anion."),
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Acyl Substitution",
                reactions: [
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Radical",
                reactions: [
                    ReactionFile(
                        name: "Intramolecular HAT", filename: "HAT_Butoxy", transitionState: 426,
                        description: ""),
                    ReactionFile(
                        name: "Hydrogen Atom Transfer (HAT): CH₄ + Cl Radical", filename: "MethaneChlorineRadical", transitionState: 55,
                        description: "This trajectory shows the collision of a chloride radical with methane. The transition state shows the typical geometry for radical atom transfers where there is a linear arrangement of the Cl-H-C. The transition state also shows the change from tetrahedral to a planar carbon."),
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Pericyclic",
                reactions: [
                    ReactionFile(
                        name: "Cope: 1,5-hexadiene", filename: "hexadiene_cope_hexadiene_complete", transitionState: 501,
                        description: "This trajectory shows the conformational change required to stack the π bonds to enable a one-step concerted rearrangement. The transition state involves a chair type structure with two stacked allylic fragments."),
                    ReactionFile(
                        name: "Cope: 3,4-Dimethylhexa-1,5-diene", filename: "dimethylhexadiene_cope_octadiene_complete", transitionState: 849,
                        description: "The beginning of this trajectory shows the conformational change required to achieve the highly organized [3,3] sigmatropic rearrangement transition state. Press the TS button to look at the transition-state structure, which has a chair conformation and can be thought of as two allyl systems interacting. After the transition state the structure unwraps through another conformational change."),
                    ReactionFile(
                        name: "Diels-Alder: 1,3-Butadiene + Ethylene", filename: "butadiene_ethene_DA_cyclohexane_complete", transitionState: 200,
                        description: "This Diels-Alder trajectory shows the collision between the s-cis conformation of 1,3-butadiene with ethylene. The reactive collision geometry allows the ethylene to interact with one face of the diene at the C-1 and C-4 carbons. This one-step, concerted reaction forms cyclohexene."),
                    ReactionFile(
                        name: "Diels-Alder: 1,3-Butadiene + Enone", filename: "butadiene_acrylate_DA_cyclohexenecarboxylate_complete", transitionState: 449,
                        description: "The Diels-Alder reaction is typically a one-step reaction without an intermediate that forms two C-C bonds. The transition state has an orientation where the s-cis conformation of the 1,3-diene is stacked on top of the dienophile π bonds."),
                    ReactionFile(
                        name: "Electrocyclic: Cyclobutene", filename: "Ringclosure_Butadiene", transitionState: 1000,
                        description: ""),
                    ReactionFile(
                        name: "Electrocyclic: 3,4-Dimethylcyclobutene", filename: "hexadiene_TS_dimethylcyclobutene", transitionState: 1000,
                        description: "This trajectory shows the cyclization of 2,4-hexadiene to dimethylcyclobutene. This trajectory first shows the rapid interconversion between s-trans and s-cis conformations of 2,4-hexadiene before achieving the transition state for C-C bond formation. Move the trajectory reverse and forward from the transition state to see the conrotatory motion."),
                    ReactionFile(
                        name: "Ene: Propylene + Ethylene", filename: "EneReaction", transitionState: 127,
                        description: "The ene reaction is a generally a concerted, one-step process where an allylic C-H bond is broken and transferred to an alkene. There is also formation of a new C-C bond."),
                    ReactionFile(
                        name: "OsO₄ + Ethylene", filename: "OsO4_complete", transitionState: 501,
                        description: "This collision shows the alkene nucleophile reacting with the OsO4 electrophile in a one-step cycloaddition type reaction. The OsO4 can be thought of as a diene type reactant. Notice that even though OsO4 is symmetric an individual reactive collision might be slightly asynchronous, that is having the forming O-C bonds be slightly different lengths."),
                    ReactionFile(
                        name: "1,3-Dipolar Cycloaddition: O₃ + Ethylene", filename: "Ozone_complete", transitionState: 499,
                        description: "Ozone is an example of a 1,3-dipole reagent. The anionic allylic type π system reacts similarly to dienes with alkenes in a one-step cycloaddition reaction. Notice that despite the 1,3-dipole having formal charges the reaction is a concerted, one-step process. While on average each reactive collision will have two identical forming C-O bond distances an individual trajectory may have slightly asynchronous distances."),
                ].sorted(by: { $0.name < $1.name })),
    SubCategory(name: "Aromatic Substitution",
                reactions: [
                    ReactionFile(
                        name: "Friedel-Crafts Acylation", filename: "Toluene_acylium_AlCl4_TS_tolylethanone", transitionState: 499,
                        description: ""),
                ].sorted(by: { $0.name < $1.name })),
    /*SubCategory(name: "Uncategorized",
                reactions: [
                ]),*/
]

struct ReactionSelectionView: View {
    var body: some View {
         ZStack {
            List(subCategories/*.filter{ $0.reactions.count > 0 }*/, id: \.name) { r in
                NavigationLink(destination: Submenu(reactions: r.reactions, previous: r.name)) {
                    Text(r.name)
                }
                .navigationBarTitleDisplayMode(.inline)
                .navigationBarHidden(false)
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
    
    struct ReactionSelectionView_Previews: PreviewProvider {
        static var previews: some View {
            ReactionSelectionView()
        }
    }
}
