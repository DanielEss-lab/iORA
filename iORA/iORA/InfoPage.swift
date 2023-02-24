//
//  Infopage.swift
//  iORA
//
//  Created by Jared Rossberg on 12/23/22.
//

import SwiftUI

var onInfoPage = false

struct InfoPage: View {
    let contents: String
    
    var body: some View {
        List {
            Section {
                Text(contents)
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

struct InfoPage_Previews: PreviewProvider {
    static var previews: some View {
        InfoPage(contents: "The text goes here")
    }
}
