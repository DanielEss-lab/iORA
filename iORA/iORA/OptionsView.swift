//
//  OptionsView.swift
//  iORA
//
//  Created by Jeremiah Brown on 05/21/22.
//

import Foundation
import SwiftUI
import SceneKit
import Combine

/*class OptionsViewHostingController: UIHostingController<OptionsView> {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder, rootView: OptionsView())
    }
}*/

extension UIApplication {
    static var appVersion: String? {
        return Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
    }
}

enum LightSources: String, CaseIterable, Identifiable {
    case ambient, directional, omni, spot
    var id: Self { self }
}

struct OptionsView: View {
    enum Size: String, CaseIterable, Identifiable {
        case small, normal, large
        var id: Self { self }
    }
    @State private var selectedAtomSize: Size = .normal
    @State private var selectedBondSize: Size = .normal
    @State private var coloredToggle = true
    @State private var transparentToggle = true
    @State private var bgColor: Color = Color.blue
    @State private var selectedLightSource: LightSources = .directional
    
    @State private var isPresentingConfirm: Bool = false
    
    var body: some View {
        List {
            Section(header: Text("Sizing")) {
                HStack {
                    Text("Bond Sizes")
                    Picker("Bond Sizes", selection: $selectedBondSize) {
                        ForEach(Size.allCases) { size in
                            Text(size.rawValue.capitalized)
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(.menu)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
            
                HStack {
                    Text("Atom Sizes")
                    Picker("Atom Sizes", selection: $selectedAtomSize) {
                        ForEach(Size.allCases) { size in
                            Text(size.rawValue.capitalized)
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(.menu)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
            
            Section(header: Text("Appearance")) {
                HStack {
                    Text("Lighting")
                    Picker("Lighting", selection: $selectedLightSource) {
                        ForEach(LightSources.allCases) { source in
                            Text(source.rawValue.capitalized)
                        }
                    }
                    .labelsHidden()
                    .pickerStyle(.menu)
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                ColorPicker("Background Color",
                            selection: $bgColor,
                            supportsOpacity: false)
                Toggle("Colored Bonds", isOn: $coloredToggle)
                Toggle("Transparent Bonds", isOn: $transparentToggle)
            }
            
            Section() {
                Text("Developed by Gabriel Reed, Jared Rossberg, Jeremiah Brown, Shusen Chen, and Prof. Daniel H. Ess").font(.footnote)
            }
            
            Section() {
                Button("Reset Settings") {
                  isPresentingConfirm = true
                }
                .foregroundColor(.red)
                .frame(maxWidth: .infinity, alignment: .center)
                .actionSheet(isPresented: $isPresentingConfirm) {
                    ActionSheet(
                        title: Text("This action will reset all settings and cannot be undone."),
                        buttons: [
                            .destructive(Text("Reset Settings")) {
                                UserDefaults.standard.set(false, forKey: "SET_UP_PERFORMED_2")
                                let defaults = Defaults()
                                defaults.setUp()
                                self.loadSettings()
                                isPresentingConfirm = false
                            },
                            .cancel()
                        ]
                    )
                }
            }
            
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.large)
        .onAppear {
            self.loadSettings()
        }
        .onDisappear {
            self.saveSettings()
        }
    }
    
    func loadSettings() {
        var temp = UserDefaults.standard.double(forKey: "BOND_RADIUS")
        switch temp {
        case _ where temp < 0.04:
            self.selectedBondSize = .small
        case 0.04..<0.09:
            self.selectedBondSize = .normal
        case _ where temp >= 0.09:
            self.selectedBondSize = .large
        default:
            self.selectedBondSize = .normal
        }
        
        temp = UserDefaults.standard.double(forKey: "ATOM_RADIUS_MULTIPLIER")
        switch temp {
        case _ where temp < 0.75:
            self.selectedAtomSize = .small
        case 0.75..<1.5:
            self.selectedAtomSize = .normal
        case _ where temp >= 1.5:
            self.selectedAtomSize = .large
        default:
            self.selectedAtomSize = .normal
        }
        
        self.coloredToggle = UserDefaults.standard.bool(forKey: "ARE_BONDS_COLORED")
        self.transparentToggle = UserDefaults.standard.bool(forKey: "ARE_BONDS_TRANSPARENT")
        self.bgColor = Color(UserDefaults.standard.backgroundColor!)
        self.selectedLightSource = LightSources(rawValue: UserDefaults.standard.string(forKey: "LIGHT_SOURCE")!) ?? .directional
    }
    
    func saveSettings() {
        switch self.selectedAtomSize {
        case Size.small:
            UserDefaults.standard.set(0.5, forKey: "ATOM_RADIUS_MULTIPLIER")
        case Size.normal:
            UserDefaults.standard.set(1.0, forKey: "ATOM_RADIUS_MULTIPLIER")
        case Size.large:
            UserDefaults.standard.set(2.0, forKey: "ATOM_RADIUS_MULTIPLIER")
        }
        
        switch self.selectedBondSize {
        case Size.small:
            UserDefaults.standard.set(0.03, forKey: "BOND_RADIUS")
        case Size.normal:
            UserDefaults.standard.set(0.06, forKey: "BOND_RADIUS")
        case Size.large:
            UserDefaults.standard.set(0.12, forKey: "BOND_RADIUS")
        }
        
        UserDefaults.standard.set(self.selectedLightSource.rawValue, forKey: "LIGHT_SOURCE")
        UserDefaults.standard.backgroundColor = UIColor(self.bgColor)
        UserDefaults.standard.set(self.coloredToggle, forKey: "ARE_BONDS_COLORED")
        UserDefaults.standard.set(self.transparentToggle, forKey: "ARE_BONDS_TRANSPARENT")
    }
}


struct OptionsView_Previews: PreviewProvider {
    static var previews: some View {
        OptionsView()
    }
}
