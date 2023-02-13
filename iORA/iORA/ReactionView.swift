//
//  ReactionView.swift
//  iORA
//
//  Created by Jared Rossberg on 1/12/22.
//

import SwiftUI
import UIKit

struct InfoViewButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .padding()
            //.background(Color(red: 0, green: 0, blue: 0.5))
            .background(Color(red: 0.09, green: 0.28, blue: 0.59))
            .foregroundColor(.white)
            .clipShape(Capsule())
    }
}

struct ReactionView: View {
    let reactionFile: ReactionFile
    @State private var isShowingInfoView = false
    
    var body: some View {
        VStack {
            Text(reactionFile.name)
                .font(.system(size: 20))
                .bold()
            ReactionStoryboardViewController(filename: reactionFile.filename, transitionState: reactionFile.transitionState)
        }
        .toolbar {
            NavigationLink(destination: InfoPage(contents: reactionFile.description)) {
                getToolbar()
            }
        }
    }
    
    func getToolbar() -> AnyView {
        if reactionFile.description.isEmpty {
            return AnyView(EmptyView())
        } else {
            return AnyView(Text("Rxn Info")
                .padding(5)
                .overlay(Capsule()
                    .stroke(lineWidth: 2)
            ))
        }
    }
}

var globalReaction = ""
var globalTransitionState = 0

struct ReactionStoryboardViewController: UIViewControllerRepresentable {
    let filename: String
    let fileLoader = FileLoader()
    
    init(filename: String, transitionState: Int) {
        self.filename = filename
        globalTransitionState = transitionState
        globalReaction = filename
    }
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let storyboard = UIStoryboard(name: "View", bundle: Bundle.main)
        let controller = storyboard.instantiateInitialViewController()
        return controller!
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
    }
    
}

