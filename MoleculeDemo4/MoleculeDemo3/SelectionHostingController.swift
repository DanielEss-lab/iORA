//
//  SelectionHostingController.swift
//  MoleculeDemo4
//
//  Created by Jared Rossberg on 10/12/21.
//

import UIKit
import SwiftUI

class SelectionHostingController: UIHostingController<ReactionSelectionView> {

    required init?(coder: NSCoder) {
        super.init(coder: coder,rootView: ReactionSelectionView());
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
