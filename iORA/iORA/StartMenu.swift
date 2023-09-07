//
//  StartMenu.swift
//  iORA
//
//  Created by Jeremiah Brown on 8/29/23.
//

import SwiftUI

struct HomepageButtonStyle1: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color("Foreground"))
            .foregroundColor(Color("Background"))
            .clipShape(Capsule())
    }
}

struct HomepageButtonStyle2: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            .background(Color("Background"))
            .foregroundColor(Color("Foreground"))
            .overlay(
                RoundedRectangle(cornerRadius: 50)
                        .stroke(Color("Foreground"), lineWidth: 8)
            )
            .clipShape(Capsule())
    }
}
struct StartMenu: View {
    @State private var isShowingReactionSelectionView = false
    @State private var isShowingHowToView = false
    
    var body: some View {
        
        NavigationView {
            VStack() {
                Spacer().frame(height: 165)
                Image("iORA Logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 309, height: 114)
                
                //TODO: Should rewrite this to be dynamic so it fits different devices
                Spacer().frame(height: 100)
                
                NavigationLink(destination: TutorialPage(), isActive: $isShowingHowToView) { EmptyView() }
                NavigationLink(destination: ReactionSelectionView(), isActive: $isShowingReactionSelectionView) { EmptyView() }
                
                HStack {
                    Button("Reactions") {
                        isShowingReactionSelectionView = true
                    }.buttonStyle(HomepageButtonStyle1())
                    
                    Button("How To") {
                        isShowingHowToView = true
                    }.buttonStyle(HomepageButtonStyle2())
                }
                
                Spacer()
                
            }
        }.navigationViewStyle(.stack)
    }
    
}

struct StartMenu_Previews: PreviewProvider {
    static var previews: some View {
        StartMenu()
        
        StartMenu()
            .environment(\.colorScheme, .dark)
    }
}
