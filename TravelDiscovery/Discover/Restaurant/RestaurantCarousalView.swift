//
//  RestaurantCarousalView.swift
//  TravelDiscovery
//
//  Created by Matthew Garlington on 12/8/20.
//

import SwiftUI
import KingfisherSwiftUI


struct RestaurantCarousalView: UIViewControllerRepresentable {
    
    let imageURLStrings: [String]
    let selectedIndex: Int
    
    func makeUIViewController(context: Context) -> UIViewController {
        let pvc = CarousalViewController(imageURLStrings: imageURLStrings, selectedIndex: selectedIndex)
        return pvc
    }
    
    
    typealias UIViewControllerType = UIViewController
    
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}

class CarousalViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        allControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        self.selectedIndex
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = allControllers.firstIndex(of: viewController) else {return nil}
        
        if index == 0 {return nil}
        
        return allControllers[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = allControllers.firstIndex(of: viewController) else {return nil}
        
        if index == allControllers.count - 1 {return nil}
        
        return allControllers[index + 1]
    }
    
    
    
    
    var allControllers: [UIViewController] = []
    var selectedIndex: Int

    
    init(imageURLStrings: [String], selectedIndex: Int) {
        self.selectedIndex = selectedIndex
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.systemGray5
        UIPageControl.appearance().currentPageIndicatorTintColor =  .red
        
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        view.backgroundColor = nil
        
        
        allControllers = imageURLStrings.map({
            imageName in
            let hostingController = UIHostingController(rootView:
                                                        ZStack {
                                                            Color.black
                                                            KFImage(URL(string: imageName))
                                                        
                                                            .resizable()
                                                            .scaledToFit()
                                                        }
            )
            hostingController.view.clipsToBounds = true
            return hostingController
            
        })
        if selectedIndex < allControllers.count {
            setViewControllers([allControllers[selectedIndex]], direction: .forward, animated: true, completion: nil)
        }
        
      
        
//        if let first = allControllers.first {
//            setViewControllers([first], direction: .forward, animated: true, completion: nil)
//
            
            self.dataSource = self
            self.delegate = self
        
            
        }
        
      
    
    
    required init?(coder: NSCoder) {
        fatalError("Init(coder: ) has not been implemented")
    }
}


struct RestaurantCarousalView_Previews: PreviewProvider {
    static let imageUrlStrings = [
        "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/2240d474-2237-4cd3-9919-562cd1bb439e",
        "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/b1642068-5624-41cf-83f1-3f6dff8c1702",
        "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/6982cc9d-3104-4a54-98d7-45ee5d117531"
    ]
    static var previews: some View {
        RestaurantCarousalView(imageURLStrings: imageUrlStrings, selectedIndex: 5)
        .frame(height: 300)
    }
}
