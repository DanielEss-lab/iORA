//
//  homepage.swift
//  iORA
//
//  Created by Jared Rossberg on 12/22/22.
//

import SwiftUI

struct HomepageButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color(red: 0, green: 0, blue: 0.5))
            .foregroundColor(.white)
            .clipShape(Capsule())
    }
}

struct Homepage: View {
    @State private var isShowingReactionSelectionView = false
    @State private var isShowingHowToView = false
    
    var body: some View {
        NavigationView {
            VStack() {
                NavigationLink(destination: TutorialPage(), isActive: $isShowingHowToView) { EmptyView() }
                NavigationLink(destination: ReactionSelectionView(), isActive: $isShowingReactionSelectionView) { EmptyView() }
                
                Text("iORA")
                    .font(.largeTitle)
                    .padding()
                
                Spacer()
                
                //HStack {
                    Button("Reactions") {
                        isShowingReactionSelectionView = true
                    }.buttonStyle(HomepageButtonStyle())
                    
                    Button("How To") {
                        isShowingHowToView = true
                    }.buttonStyle(HomepageButtonStyle())
                //}
                
                Spacer()
                
                /*List {
                    Section {}
                    Section {
                        Button("Reactions") {
                            isShowingReactionSelectionView = true
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                    Section {
                        Button("How To") {
                            isShowingHowToView = true
                        }
                        .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
                .listStyle(.insetGrouped)*/
                
            }
            
        }
    }
    
}

struct homepage_Previews: PreviewProvider {
    static var previews: some View {
        Homepage()
    }
}
