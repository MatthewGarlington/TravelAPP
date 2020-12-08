//
//  Dish.swift
//  TravelDiscovery
//
//  Created by Matthew Garlington on 12/8/20.
//

import SwiftUI

struct Dish: Decodable, Hashable {
    let name, price, photo: String
    let numPhotos: Int
}


