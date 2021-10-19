//
//  ReactionView.swift
//  MoleculeDemo4
//
//  Created by Jared Rossberg on 10/19/21.
//

import SwiftUI
import UIKit

struct ReactionView: View {
    let reactionFile: ReactionFile
    
    var body: some View {
        Text(reactionFile.name)
            .font(.system(size: 20))
            .bold()
        ReactionStoryboardViewController(filename: reactionFile.filename)
    }
}

struct ReactionStoryboardViewController: UIViewControllerRepresentable {
    let filename: String
    let fileLoader = FileLoader()
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let storyboard = UIStoryboard(name: "Reaction", bundle: Bundle.main)
        let controller = storyboard.instantiateInitialViewController()
        return controller!
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        let bundle = Bundle.main
        let path = bundle.path(forResource: filename, ofType: "sdf")
        do {
            let reaction = try fileLoader.parseReactionFile(inputFile: path).getReaction()
            print(filename, "has", reaction.getStates().count, "states")
        } catch {
            print("Error while loading sdf file:", filename)
        }
    }
}

