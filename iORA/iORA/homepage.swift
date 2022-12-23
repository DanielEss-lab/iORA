//
//  homepage.swift
//  iORA
//
//  Created by Jared Rossberg on 12/22/22.
//

import SwiftUI

struct Homepage: View {
    var moveToNextPage = false
    var body: some View {
        NavigationView {
            VStack {
                Text("Homepage")
                NavigationLink(destination: ReactionSelectionView()) {
                    Text("Reactions")
                }.navigationBarTitleDisplayMode(.inline)
                NavigationLink(destination: TutorialPage()) {
                    Text("How To Use")
                }.navigationBarTitleDisplayMode(.inline)
            }
            
        }
    }
}

struct homepage_Previews: PreviewProvider {
    static var previews: some View {
        Homepage()
    }
}
