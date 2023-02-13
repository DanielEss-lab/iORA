//
//  Infopage.swift
//  iORA
//
//  Created by Jared Rossberg on 12/23/22.
//

import SwiftUI

var onInfoPage = false

struct InfoPage: View {
    let contents: [AnyView]
    
    var body: some View {
        List {
            ForEach(0..<contents.count) { index in
                Section {
                    self.contents[index]
                    //.padding()
                }
            }
        }
        .onDisappear {
            onInfoPage = false
        }
        .onAppear {
            onInfoPage = true
        }
    }
}

var Info_Butane_Anti_to_Gauche: [AnyView] = [
    AnyView(Text("This trajectory shows a simulation of butane with enough energy to achieve the transition state (eclipsed geometry) for rotation around the C2-C3 bond. This transition state connects the lower energy anti conformation with the higher energy gauche conformation. Notice that during the trajectory there is both rotation of both the C2-C3 bond and the C1-C2 bond, but not at the exact same time."))
]
var Info_Ethane_C_C_Rotation: [AnyView] = [
    AnyView(Text("This trajectory shows a simulation of ethane for rotation around the C-C bond. This involves proceeding through the eclipsed conformation that connects the staggered conformations."))
]
var Info_Acetone_LDA: [AnyView] = [
    AnyView(Text("This trajectory shows that the basic nitrogen must first orient properly to react with the C-H bond of acetone. This involves a linear arrangement, 180 degree angle, between the nitrogen atom, the transferring proton, and the carbon that is being deprotonated."))
]
var Info_Trifluoroacetic_Acid_Methoxide: [AnyView] = [
    AnyView(Image("Trifluoroacetic Acid-Methoxide").resizable().aspectRatio(contentMode: .fit)),
    AnyView(Text("This trajectory shows the proton transfer reaction between methoxide and trifluoroacetic acid. Hydrogen bonding precedes, but only for a very short time, proton transfer. Notice that the proton transfers back and forth very rapidly between methoxide and trifluroacetate several times before dissociation of methanol."))
]
var Info_SN1_Tert_Butyl_Iodide: [AnyView] = [
    AnyView(Text("This SN1 trajectory shows the heterolysis of the C-Br bond of tert-butyl bromide. This process generates a relatively stabilized, but still high in energy, tertiary carbocation intermediate, which can be captured by nucleophiles/Lewis bases."))
]
var Info_SN2_2_Bromobutane_Methoxide: [AnyView] = [
    AnyView(Text("This SN2 trajectory shows the methoxide nucleophile collision into the backside of the C-Br bond with enough energy and at the correct angle to induce a new O-C bond and cleavage of the C-Br bond. Note that at the beginning of the trajectory the methoxide nucleophile weakly interacts with C-H bonds adjacent to the C-Br bond. The corresponding E2 trajectory animation shows the competitive E2 reaction. The SN2 and E2 trajectories are competitive because their transition states are close in energy."))
]
var Info_SN2_Ethyl_Chloride_Cyanide: [AnyView] = [
    AnyView(Text("This SN2 trajectory shows the cyanide nucleophile collision into the backside of the C-Cl bond with enough energy and at the correct angle to induce a new CN-C bond and cleavage of the C-Cl bond."))
]
var Info_SN2_Nonproductive_Ethyl_Chloride_Cyanide: [AnyView] = [
    AnyView(Text("Most collisions between reactants do not lead to the transition state geometry. Rather, reactants often collide and bounce away from each other in what is referred to as a nonproductive collision. This trajectory shows an example where a cyanide anion collides with chloroethane without leading to the SN2 transition state. Compare this nonproductive trajectory with the productive SN2 reaction."))
]
var Info_E2_2_Bromobutane_Secondary_Methoxide: [AnyView] = [
    AnyView(Text("This E2 trajectory shows that the methoxide base deprotonates the beta anti-periplanar hydrogen on C-3. As this deprotonation occurs, the π bond is formed and the bromide is ejected. Use the transition state (TS) button to examine key distances: the base to the beta hydrogen, the C-2 to C-3 distance, and the C-Br distance."))
]
