//
//  TutorialPage.swift
//  iORA
//
//  Created by Jared Rossberg on 12/22/22.
//

import SwiftUI
import FLAnimatedImage

struct TutorialPage: View {
    var body: some View {
        ScrollView {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            GIFView(type: .name("tutorialGifs/giphy"))
                .frame(height: 300)
                .padding()
            GIFView(type: .name("tutorialGifs/giphy"))
                .frame(height: 300)
                .padding()
            GIFView(type: .name("tutorialGifs/giphy"))
                .frame(height: 300)
                .padding()
            GIFView(type: .name("tutorialGifs/giphy"))
                .frame(height: 300)
                .padding()
            GIFView(type: .name("tutorialGifs/giphy"))
                .frame(height: 300)
                .padding()
        }
    }
}

struct TutorialPage_Previews: PreviewProvider {
    static var previews: some View {
        TutorialPage()
    }
}


// The following code allows the FLAnimatedImage library to be used as a SwiftUI component

enum URLType {
    case name(String)
    case url(URL)

    var url: URL? {
        switch self {
        case .name(let name):
            return Bundle.main.url(forResource: name, withExtension: "gif")
        case .url(let remoteURL):
            return remoteURL
        }
    }
}

struct GIFView: UIViewRepresentable {
    private var type: URLType

    init(type: URLType) {
        self.type = type
    }
    
    private let imageView: FLAnimatedImageView = {
        let imageView = FLAnimatedImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 0
        imageView.layer.masksToBounds = true
        return imageView
    } ()

    private let activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    } ()
    
    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)

        view.addSubview(activityIndicator)
        view.addSubview(imageView)

        imageView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true

        activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        activityIndicator.startAnimating()
        guard let url = type.url else { return }

        DispatchQueue.global().async {
            if let data = try? Data(contentsOf: url) {
                let image = FLAnimatedImage(animatedGIFData: data)

                DispatchQueue.main.async {
                    activityIndicator.stopAnimating()
                    imageView.animatedImage = image
                }
            }
        }
    }
}
