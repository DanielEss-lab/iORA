//
//  HostingController.swift
//  iORA
//
//  Created by Jared Rossberg on 1/12/22.
//

import UIKit
import SwiftUI

class HostingController: UIHostingController<StartMenu> {

    required init?(coder: NSCoder) {
        super.init(coder: coder,rootView: StartMenu());
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
