//
//  SwiftDestinationHeaderContainerUIView.swift
//  TravelDiscovery
//
//  Created by Matthew Garlington on 12/7/20.
//

import SwiftUI


 struct DestinationHeaderContainer: UIViewControllerRepresentable {
     func makeUIViewController(context: Context) -> UIViewController {
         let redVC = UIViewController()
         redVC.view.backgroundColor = .red
         return redVC
     }
     
     
     typealias UIViewControllerType = UIViewController
     
     
     func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
         
     }
 }

struct SwiftDestinationHeaderContainerUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftDestinationHeaderContainerUIView()
    }
}
