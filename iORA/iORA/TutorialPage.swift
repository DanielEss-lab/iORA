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
    let images = ["iORA Logo","2","3","4","5"]
    
    var body: some View {
        
        ZStack{
            
            Color("Background")
            
            TabView(selection : $selection){
                
                ForEach(0..<5){ i in
                    Image("\(images[i])")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }

                
            }.tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        }
    }
}

struct TutorialPage_Previews: PreviewProvider {
    static var previews: some View {
        TutorialPage()
    }
}
