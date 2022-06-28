//
//  OptionsView.swift
//  iORA
//
//  Created by Jeremiah Brown on 05/21/22.
//

import Foundation
import SwiftUI
import SceneKit

class OptionsViewHostingController: UIHostingController<OptionsView> {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: OptionsView())
    }
}

struct OptionsView: View {
    @State private var radius = ""
    var body: some View {
        VStack(alignment: .center) {
            TextField("Bond Width", text: $radius)
        }
        .onDisappear {
            self.assignRadius()
        }
    }

    func assignRadius()
    {
        if radius != "0"
        {
            UserDefaults.standard.set(Double(radius), forKey: "BOND_RADIUS")
        }
    }
}


struct OptionsView_Previews: PreviewProvider {
    static var previews: some View {
        OptionsView()
    }
}
