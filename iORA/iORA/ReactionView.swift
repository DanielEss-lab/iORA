//
//  ReactionView.swift
//  iORA
//
//  Created by Jared Rossberg on 1/12/22.
//

import SwiftUI
import UIKit

struct ReactionView: View {
    let reactionFile: ReactionFile
    
    var body: some View {
        VStack {
            Text(reactionFile.name)
                .font(.system(size: 20))
                .bold()
            ReactionStoryboardViewController(filename: reactionFile.filename, transitionState: reactionFile.transitionState)
        }
        .toolbar {
            NavigationLink(destination: Infopage(reaction: reactionFile)) {
                Image(systemName: "info.circle")
                    .padding()
            }
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

