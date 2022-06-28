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
    var body: some View {
        VStack {
            Spacer()
            Text("Settings will be here soon!")
            Spacer()
            Spacer()
            Spacer()
        }
    }
}


struct OptionsView_Previews: PreviewProvider {
    static var previews: some View {
        OptionsView()
    }
}
