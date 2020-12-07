//
//  Attraction.swift
//  TravelDiscovery
//
//  Created by Matthew Garlington on 12/7/20.
//

import SwiftUI

struct Attraction: Identifiable  {
    let id = UUID().uuidString
    
    let name, imageName: String
    let latitude, longitude: Double
}

