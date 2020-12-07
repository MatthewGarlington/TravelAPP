//
//  NavigationLazyView.swift
//  TravelDiscovery
//
//  Created by Matthew Garlington on 12/5/20.
//

import SwiftUI

struct NavigationLazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @ escaping () -> Content) {
        self.build = build
        
    }
    var body: Content {
        build()
    }
}
