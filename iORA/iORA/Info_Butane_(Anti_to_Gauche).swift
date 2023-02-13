//
//  Info_Butane_(Anti_to_Gauche).swift
//  iORA
//
//  Created by Jared Rossberg on 2/13/23.
//

import SwiftUI

struct Info_Butane_Anti_to_Gauche: View {
    var body: some View {
        Text("This trajectory shows a simulation of butane with enough energy to achieve the transition state (eclipsed geometry) for rotation around the C2-C3 bond. This transition state connects the lower energy anti conformation with the higher energy gauche conformation. Notice that during the trajectory there is both rotation of both the C2-C3 bond and the C1-C2 bond, but not at the exact same time.")
    }
}

struct Info_Butane__Anti_to_Gauche__Previews: PreviewProvider {
    static var previews: some View {
        Info_Butane_Anti_to_Gauche()
    }
}
