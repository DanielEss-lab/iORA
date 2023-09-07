//
//  TutorialPage.swift
//  iORA
//
//  Created by Jeremiah on 8/29/23.
//

import SwiftUI

struct TutorialPage: View {
    @State private var selection = 0
    
    ///  images with these names are placed  in my assets
    let images = ["tutorial_1","tutorial_2","tutorial_3","tutorial_4","tutorial_5", "tutorial_6"]
    
    var body: some View {
        
        ZStack{
            
            Color("Background")
            
            TabView(selection : $selection){
                
                ForEach(0..<6){ i in
                    Image("\(images[i])")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }

                
            }.tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))//.padding(.horizontal, 40)
        }
    }
}

struct TutorialPage_Previews: PreviewProvider {
    static var previews: some View {
        TutorialPage()
    }
}
