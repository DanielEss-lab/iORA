//
//  HostingController.swift
//  iORA
//
//  Created by Jared Rossberg on 1/12/22.
//

import UIKit
import SwiftUI

//class HostingController: UIHostingController<ReactionSelectionView> {
class HostingController: UIHostingController<Homepage> {
    

    required init?(coder: NSCoder) {
        //super.init(coder: coder,rootView: ReactionSelectionView());
        super.init(coder: coder,rootView: Homepage());
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
