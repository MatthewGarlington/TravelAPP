//
//  DestinationHeaderContainer.swift
//  TravelDiscovery
//
//  Created by Matthew Garlington on 12/7/20.
//

import SwiftUI


struct DestinationHeaderContainer: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
       let pvc = CustomPageViewController()
        return pvc
    }
    
    
    typealias UIViewControllerType = UIViewController
    
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        
    }
}

class CustomPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        allControllers.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        0
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
    
    
    let firstVC = UIHostingController(rootView: Text("First View Controller"))
    let secondVC = UIHostingController(rootView: Text("This is the Second View"))
    let thirdVC = UIHostingController(rootView: Text("Third View controller"))
    
    lazy var allControllers: [UIViewController] = [firstVC, secondVC, thirdVC
    ]
    
    
    init() {
        
        UIPageControl.appearance().pageIndicatorTintColor = UIColor.systemGray5
        UIPageControl.appearance().currentPageIndicatorTintColor = .red
        
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        view.backgroundColor = nil
        
        
        setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        self.dataSource = self
        self.delegate = self
    }


required init?(coder: NSCoder) {
    fatalError("Init(coder: ) has not been implemented")
}
}

struct DestinationHeaderContainer_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            PopularDestinationDetailsView(destinations: .init(name: "Paris", country: "France", imageName: "eiffel_tower", latitude: 48.859565, longitude: 2.353235))
        }
        DestinationHeaderContainer()
    }
}
